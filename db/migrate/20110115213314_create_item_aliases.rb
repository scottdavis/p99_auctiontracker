class CreateItemAliases < ActiveRecord::Migration
  def self.up
    create_table :item_aliases do |t|
      t.string :alias
      t.belongs_to :item

      t.timestamps
    end
  end

  def self.down
    drop_table :item_aliases
  end
end
