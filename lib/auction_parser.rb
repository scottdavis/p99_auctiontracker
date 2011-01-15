require 'safe_fork'
class AuctionParser
  attr_accessor :raw_data, :item_cache, :mode
  COMMON_BAD_WORDS = %w(sro nk pst bard monk pl cleric druid wizard warrior paladin nerco mage sk paying payin payments pc plat pall value decent want were with within mezzed haggle low anyone full each ea for buying sell my pair per port res rez ress rezes will willing wis wisdom x paying from pet first last bid you 1 lol lvl lv lvlv with or)
  def self.from_upload(raw_data)
    new(raw_data)
  end
  
  def initialize(file_name_or_string)
    @raw_data = file_name_or_string
    @mode = :file
    @item_count = 0
    @item_cache = []
    if File.exists? @raw_data
      counter = 0
      File.open(@raw_data, "r") do |infile|
        while (line = infile.gets)
          next unless line =~ /auctions?/ 
          split_string_and_filter_auctions line
          counter += 1
        end
        puts "#{counter} auction lines found"
      end
    else
      @mode = :string
      @raw_data.split("\n").each do |line|
        split_string_and_filter_auctions line
      end
    end
  end
  
  def go!
    item_cache.each do |item|
      Item.create_from_parse(item)
    end
    @item_cache = nil
  end
  
  
  def item_count
    @item_count
  end
  
  def split_string_and_filter_auctions(string)
        string.strip!
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
              price = item[1] #item[1].gsub!(/[oO]/, '0').gsub!(/[\/\-_\.]/, '') unless item[1].blank?
              price = price.gsub(/[oO]/, '0')
              if price.include?('k')
                price = price.to_f * 1000
              else
                price = price.gsub(/[\.\-]/, '')
              end
              item_cache << {:player => string[:player].strip, :item => item[0], :price => price.to_i.to_s, :time => string[:time]}
            end
          end
        end
      end

      def parse_items(string)
        regex = /([-_\'\sa-zA-Z]+)\s+?([0-9oO\.k]+)/
        items = string.scan(regex)
        items.each do|item|
          item[0].gsub!(/(\sand\s|wts|wtt|wtb)/i, '')
          item[0].gsub!(/[\s]+[p|-]+$/i, '')
          item[0].strip!
          item[0].gsub!(/^['"p|-]+[\s]+/i, '')
        end
        items
      end
      
      
      def self.is_item?(item)
        item = item.downcase
        ItemCache.exists?(["LOWER(name) = ?", item])
      end
      
      def self.get_item(item)
        ItemCache.find(:first, :conditions => ["LOWER(name) = ?", item.downcase])
      end
      
      def self.clean_items
        Item.all.each do |item|
          if self.is_item(item.name)
            cache = self.get_item(item.nam)
            item.item_cache = cache
            item.hidden = false
            item.save
          else
            item.hidden = true
            item.save
            puts item.name
            puts 'no item'
          end
        end
      end
      
end