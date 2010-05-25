require 'digest/md5'
class Auction < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :time
  validates_presence_of :price
  validates_presence_of :item_id
  
  def get_digest
    i = self.item
    if i.blank?
      return
    end
    Digest::MD5.hexdigest("#{self.time.to_s}#{i.id}#{self.price}")
  end
  
  before_create :gen_hash
  
  
  def gen_hash
    self.hash_data = get_digest
  end
  
end
