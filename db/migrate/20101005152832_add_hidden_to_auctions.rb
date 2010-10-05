class AddHiddenToAuctions < ActiveRecord::Migration
  def self.up
    add_column :auctions, :hidden, :boolean, :default => false
  end

  def self.down
    remove_column :auctions, :hidden
  end
end
