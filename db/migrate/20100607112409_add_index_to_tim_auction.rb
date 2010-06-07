class AddIndexToTimAuction < ActiveRecord::Migration
  def self.up
    add_index :auctions, :time
    add_index :auctions, :price
  end

  def self.down
    remove_index :auctions, :time
    remove_index :auctions, :price
  end
end
