class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.timestamp :time
      t.decimal :price, :percision => 6, :scale => 2
      t.belongs_to :item
      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end
