require 'test_helper'
require 'shoulda'

class Tempfile
  def tempfile
    self
  end
end

class AuctionControllerTest < ActionController::TestCase
  # Replace this with your real tests.
    context "Load index" do
      setup do
        10.times do 
          i = Factory(:item)
          50.times { Factory(:auction, :item => i)}
        end
        get :index, :letter => 'i'
      end
      should assign_to :items
      should assign_to :search
      should respond_with :success
      should render_template :index
      should_not set_the_flash
      should "have 10 items" do
        assert_equal 10, assigns(:items).size
      end
      should "have 10 auctions per item" do
        assigns(:items).each do |item|
          assert_equal 50, item.auctions.size
        end
      end
    end
    
    context "Do a search" do
      setup do
        i = Item.create(:name => "FBSS")
        50.times { Factory(:auction, :item => i)}
        get :search, :search => {:search => "fbss"}
      end
      should assign_to :items
      should assign_to :search
      should respond_with :success
      should render_template :index
      should_not set_the_flash
      should "contain one result" do
        assert_equal 1, assigns(:items).size
      end
      should "set search to fbss" do
        assert_equal 'fbss', assigns(:search)
      end
    end
    
    context "do upload" do
      setup do
        assert_difference("Log.count", +1) do
          file = fixture_file_upload('staris_log.txt','text/plain')
          post :create, :upload => {:log => file}
        end
      end
      
      should respond_with :success
      should render_template :create
      
      
    end
end
