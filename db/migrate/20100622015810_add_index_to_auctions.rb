class AddIndexToAuctions < ActiveRecord::Migration
  def self.up
    add_index :auctions, :item_id
    add_index :auctions, :hash_data
  end

  def self.down
    remove_index :auctions, :hash_data
    remove_index :auctions, :item_id
  end
end
