require 'digest/md5'
class Item < ActiveRecord::Base
  has_many :auctions, :dependent => :destroy
  validates_presence_of :name
  belongs_to :item_cache
  
  scope :name_starts_with, lambda {|letter|
      {:conditions => ['lower(name) like ?', "#{letter}%"]}
    }
  scope :search_for, lambda {|search|
      {:conditions => ["lower(name) LIKE ?", "%#{search}%"]}
    }
  scope :not_hidden, {:conditions => {:hidden => false}}
  
  
  def self.create_from_parse(hash)
    i = Item.find_or_create_by_name(self.sanitize(hash[:item].downcase))
    return if i.blank?
    auction = Auction.new
    auction.item = i
    auction.price = hash[:price].to_i
    auction.time = Time.parse hash[:time]
    auction.player = hash[:player]
    auction.created_at = auction.updated_at = Time.now
   unless Auction.exists?(:hash_data => auction.digest) 
     auction.save! if auction.valid?
   end
     
  end  
  
  def self.sanitize(name)
    regexs = [/^[-']+(.+)/, /(.+)[-']+$/]
    regexs.each {|regex| name.gsub!(regex, $1) if name =~ regex }
    name.strip
  end
  
  def hide!
    #self.hidden = true
    #save
    true
  end
  
end
