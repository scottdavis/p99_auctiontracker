class Item < ActiveRecord::Base
  has_many :auctions, :dependent => :destroy
  validates_presence_of :name
  
  
  named_scope :name_starts_with, lambda {|letter|
      {:conditions => ['lower(name) like ?', "#{letter}%"]}
    }
  
  
  
  def self.create_from_parse(item)
   # puts self.sanitize(item[:item].downcase)
    @item = Item.find_or_create_by_name(self.sanitize(item[:item].downcase))
    auction = Auction.new
    auction.item = @item
    if item[:price].include?('k')
      item[:price] = item[:price].to_f * 1000
    end
    auction.price = item[:price].to_i
    auction.time = Time.parse item[:time]
    auction.save!
  end  
  

  
  def self.sanitize(name)
    regexs = [/^[-']+(.+)/, /(.+)[-']+$/]
    regexs.each do |regex|
      name.gsub!(regex, $1) if name =~ regex  
    end
    name.strip
  end
  
  
  
end
