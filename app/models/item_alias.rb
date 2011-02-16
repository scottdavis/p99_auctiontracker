class ItemAlias < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :alias, :item_id
  
  before_save do
    #if self.item_id.is_numeric
  end
  
end
