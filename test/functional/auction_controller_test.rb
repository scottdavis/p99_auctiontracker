require 'test_helper'
require 'shoulda'
class AuctionControllerTest < ActionController::TestCase
  # Replace this with your real tests.
    context "Load index i" do
      setup do
        10.times do 
          Factory(:item)
        end
        get :index, :letter => 'i'
      end
      should_assign_to :items, :search
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
      should "have 10 items" do
        assert_equal 10, assigns(:items).size
      end
    end
    
    context "Do a search" do
      setup do
        Item.create(:name => "FBSS")
        post :search, :search => {:search => "fbss"}
      end
      should_assign_to :items, :search
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
      should "contain one result" do
        assert_equal 1, assigns(:items).size
      end
      should "ser search to fbss" do
        assert_equal 'fbss', assigns(:search)
      end
    end
end
