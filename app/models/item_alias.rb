class ItemAlias < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :alias, :item_id
end
