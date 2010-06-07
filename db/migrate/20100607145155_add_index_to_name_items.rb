class AddIndexToNameItems < ActiveRecord::Migration
  def self.up
    add_index :items, :name
  end

  def self.down
    remove_index :items, :name
  end
end
