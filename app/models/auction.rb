class Auction < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :time
  validates_presence_of :price
  
end
