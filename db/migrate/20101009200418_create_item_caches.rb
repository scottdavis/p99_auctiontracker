class CreateItemCaches < ActiveRecord::Migration
  def self.up
    create_table :item_caches do |t|
      t.string :name
      t.string :alla_id
      t.text :meta
      t.text :alias
      t.timestamps
    end
    add_index :item_caches, :name
    add_column :items, :item_cache_id, :integer
    add_index :items, :item_cache_id
  end

  def self.down
    drop_table :item_caches
  end
end
