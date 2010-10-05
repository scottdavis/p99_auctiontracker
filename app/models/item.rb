require 'digest/md5'
class Item < ActiveRecord::Base
  has_many :auctions, :dependent => :destroy
  validates_presence_of :name
  
  
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
  
  
  def self.create_from_parse(item)
   # puts self.sanitize(item[:item].downcase)
    @item = Item.find_or_create_by_name(self.sanitize(item[:item].downcase))
    return if @item.blank?
    auction = Auction.new
    auction.item = @item
    if item[:price].include?('k')
      item[:price] = item[:price].to_f * 1000
    end
    auction.price = item[:price].to_i
    auction.time = Time.parse item[:time]

   unless Auction.exists?(:hash_data => auction.get_digest) 
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
