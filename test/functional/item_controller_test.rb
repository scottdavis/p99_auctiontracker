require 'test_helper'

class ItemControllerTest < ActionController::TestCase
  context "show" do
    setup do
      i = Factory(:item)
      10.times do 
        Factory(:auction, :item => i)
      end
      get :show, :id => i.id
    end
    
    should render_template :show
    should respond_with :success
    
  end
end
