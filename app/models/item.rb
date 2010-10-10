require 'digest/md5'
class Item < ActiveRecord::Base
  has_many :auctions, :dependent => :destroy
  validates_presence_of :name
  belongs_to :item_cache
  
  named_scope :name_starts_with, lambda {|letter|
      {:conditions => ['lower(name) like ?', "#{letter}%"]}
    }
    
  named_scope :order, lambda {|order|
      {:order => order}
    }
  named_scope :include, lambda {|include|
      {:include => include}
    }
  named_scope :search_for, lambda {|search|
      {:conditions => ["lower(name) LIKE ?", "%#{search}%"]}
    }
  named_scope :not_hidden, {:conditions => {:hidden => false}}
  
  
  def self.create_from_parse(hash)
   # puts self.sanitize(item[:item].downcase)
    return unless AuctionParser.is_item?(hash[:item])
    i = Item.find_or_create_by_name(self.sanitize(hash[:item].downcase))
    return if i.blank?
    auction = Auction.new
    auction.item = i
    if hash[:price].include?('k')
      hash[:price] = hash[:price].to_f * 1000
    end
    auction.price = hash[:price].to_i
    auction.time = Time.parse hash[:time]
    auction.player = hash[:player].strip
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
    self.hidden = true
    save
  end
  
end
