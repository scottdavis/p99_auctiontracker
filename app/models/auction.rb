require 'digest/md5'
class Auction < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :time
  validates_presence_of :price
  validates_presence_of :item_id
  validates_presence_of :player
  
  named_scope :not_hidden, {:conditions => {:hidden => false}}
  
  def digest
    i = self.item
    if i.blank?
      return
    end
    Digest::MD5.hexdigest("#{self.time.to_s}#{i.id}#{self.price}#{self.player}")
  end
  
  before_create :gen_hash
  
  def hide!
    self.hidden = true
    save
  end
  
  def gen_hash
    self.hash_data = digest
  end
  
end
