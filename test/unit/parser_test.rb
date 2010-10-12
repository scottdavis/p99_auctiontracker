require Rails.root.join('test', 'test_helper')
class ParserTest < Test::Unit::TestCase
  context "single" do
    setup do
      string = "[Wed May 19 21:45:06 2010] Dyskinetic auctions, 'WTS braclet of woven grass 100pp'"
      string << "\n[Wed May 19 21:45:06 2010] Dyskinetic auctions, 'WTS braclet of woven grass 1.2kpp'"
      @parse = AuctionParser.new(string)
    end
    
    should "get correct aution data" do
      assert_equal 2, @parse.item_cache.size
      assert_equal({:player=>"Dyskinetic", :item => "braclet of woven grass", :time => "Wed May 19 21:45:06 2010", :price => "100"}, @parse.item_cache.first)
      assert_equal '1200', @parse.item_cache.last[:price].to_s
    end
    
  end
  
  context "multi" do
    setup do
      string =<<-EOS
        [Fri Oct 08 19:01:39 2010] Philemon auctions, 'WTS A Shimmering Orb 125p, Bracers of Battle 50p, Dwarven Axe 20p, Dwarven Ringmail Tunic 20p, 2x Bunch of Optic Nerves (for crafted bracers) 10p each'
      EOS
      @parse = AuctionParser.new(string)
    end
    
    should "have 5 items" do
      assert_equal 5, @parse.item_cache.size
    end
  end
  
  context 'assholes' do
    setup do
      string = "[Wed May 19 21:45:06 2010] Dyskinetic auctions, 'WTS braclet of woven grass 1oopp'"
      string << "\n[Wed May 19 21:45:06 2010] Dyskinetic auctions, 'WTS braclet of woven grass 1o.ooopp'"
      @parse = AuctionParser.new(string)
    end
    
    should "have two item with correnct price format" do
      assert_equal 2, @parse.item_cache.size
      assert_equal '100', @parse.item_cache.first[:price].to_s
      assert_equal '10000', @parse.item_cache.last[:price].to_s
    end
  end
  
  
  
end