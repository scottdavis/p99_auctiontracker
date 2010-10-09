require 'safe_fork'
class AuctionParser
  attr_accessor :raw_data, :item_cache
  COMMON_BAD_WORDS = %w(mezzed haggle low anyone full each ea for buying sell my pair per port res rez ress rezes will willing wis wisdom x)
  def self.from_upload(raw_data)
    new(raw_data)
  end
  
  def initialize(data)
    raw_data = data
    @item_count = 0
    @item_cache = []
    raw_data.split("\n").each do |line|
      split_string_and_filter_auctions line
    end
    run_fork unless Rails.env == 'test'
  end
  
  def run_fork
    fork = SafeFork.fork do
      items = item_cache
      items.each do |item|
        Item.create_from_parse(item)
      end
    end
    Process.detach(fork)
  end
  
  
  def item_count
    @item_count
  end
  
  def split_string_and_filter_auctions(string)
        if string =~ /^\[(.+)\](.+)/
          string = {:time => $1, :message => $2}
          if string[:message] =~ /(.+)\s(auctions,)(.+)/
            string[:player] = $1.strip
            string[:message] = $3
            items =  parse_items(string[:message])
            string[:items] = items
            string.delete(:message)
            items.each do |item|
              @item_count += 1
              next if item[0] =~ /^(selling|port|pp|sell|buy)/
              if item[0].scan(Regexp.new("\s(#{COMMON_BAD_WORDS.join('|')})\s")).size > 0
                next
              end
              item_cache << {:player => string[:player], :item => item[0], :price => item[1], :time => string[:time]}
            end
          end
        end
      end

      def parse_items(string)
        regex = /([-_\'\sa-zA-Z]+)[-\s\/,;]([0-9\.k]+)/
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