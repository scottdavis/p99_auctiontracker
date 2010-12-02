class AddFlaggedToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :flagged, :boolean
  end

  def self.down
    remove_column :items, :flagged
  end
end
