require Rails.root.join('test', 'test_helper')
class ParserTest < Test::Unit::TestCase
  context "multipules" do
    setup do
      string = "[Wed May 19 21:45:06 2010] Dyskinetic auctions, 'WTS braclet of woven grass 100pp'"
      @parse = AuctionParser.new(string)
    end
    
    should "get correct aution data" do
      assert_equal({:player=>"Dyskinetic", :item => "braclet of woven grass", :time => "Wed May 19 21:45:06 2010", :price => "100"}, @parse.item_cache.first)
    end
    
  end
  
end