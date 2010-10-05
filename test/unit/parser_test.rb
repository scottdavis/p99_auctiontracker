require Rails.root.join('test', 'test_helper')
class ParserTest < Test::Unit::TestCase
  context "multipules" do
    setup do
      string = "[Wed May 19 21:45:06 2010] Dyskinetic auctions, 'WTS braclet of woven grass 100pp'"
      @parse = AuctionParser.split_string_and_filter_auctions string
    end
    
    should "get correct aution data" do
      assert_equal({:item => "braclet of woven grass", :time => "Wed May 19 21:45:06 2010", :price => "100"}, @parse.first)
    end
    
  end
  
end