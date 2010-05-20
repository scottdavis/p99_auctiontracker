class Item < ActiveRecord::Base
  has_many :auctions
  validates_presence_of :name
  
end
