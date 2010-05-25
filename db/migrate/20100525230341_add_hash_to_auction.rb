class AddHashToAuction < ActiveRecord::Migration
  def self.up
    add_column :auctions, :hash_data, :string
    
    Auction.all.each do |auction|
      auction.hash_data = auction.get_digest
      auction.save
    end
    
    
  end

  def self.down
    remove_column :auctions, :hash_data
  end
end
