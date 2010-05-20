require 'test_helper'
require 'shoulda'
class AuctionControllerTest < ActionController::TestCase
  # Replace this with your real tests.
    context "create auction" do
      setup do
        Item.create(:name => "Flowing black robe")
      end
      should "create an auction with a item" do
        assert_difference "Auction.count", +1 do
          post :create, {:item => "Flowing black robe", :price => "9.99", :time => "Tue May 18 18:19:31 2010"}
        end
      end
      should "create an auction with a diff same item" do
        assert_difference ["Item.count", "Auction.count"], +1 do
          post :create, {:item => "Flowing black robe 2", :price => "200", :time => "Tue May 18 18:19:31 2010"}
        end
      end
    end
end
