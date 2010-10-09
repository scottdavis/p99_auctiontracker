class AddPlayerToAuctions < ActiveRecord::Migration
  def self.up
    add_column :auctions, :player, :string
    Auction.all(:conditions => {:player => nil}).each do |auc|
      auc.player = 'old data';
      auc.gen_hash
      auc.save
    end
  end

  def self.down
    remove_column :auctions, :player
  end
end
