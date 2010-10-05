class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.string :ip_address
      t.string :log
      t.timestamp :processed
      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
