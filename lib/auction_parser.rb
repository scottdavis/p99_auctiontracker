class AuctionParser
  attr_accessor :raw_data
  def self.from_upload(raw_data)
    new(raw_data)
  end
  
  def initialize(data)
    raw_data = data
    @item_count = 0
    raw_data.split("\n").each do |line|
      split_string_and_filter_auctions line
    end
  end
  
  def item_count
    @item_count
  end
  
  def split_string_and_filter_auctions(string)
        if string =~ /^\[(.+)\](.+)/
          string = {:time => $1, :message => $2}
          if string[:message] =~ /(.+auctions,)(.+)/
            string[:message] = $2
            items =  parse_items(string[:message])
            string[:items] = items
            string.delete(:message)
            items.each do |item|
              @item_count += 1
                Item.create_from_parse(:item => item[0], :price => item[1], :time => string[:time])
            end
          end
        end
      end

      def parse_items(string)
        regex = /([-_\'\sa-zA-Z]+)[-\s\/,]([0-9\.k]+)/
        items = string.scan(regex)
        items.each do|item|
          item[0].gsub!(/(and|wts|wtt|wtb)/i, '')
          item[0].gsub!(/[\s]+[p|-]+$/i, '')
          item[0].strip!
          item[0].gsub!(/^['"p|-]+[\s]+/i, '')
        end
        items
      end
      
      
end