class MoveExsistingFiles < ActiveRecord::Migration
  def self.up
    Log.all.each do |log|
      dir = Rails.root.join('public', 'system', 'logs')
      FileUtils.mkdir_p(dir)
      next unless File.exists?(log.log)
      name = File.join(dir, File.basename(log.log))
      next if name == log.log
      FileUtils.mv(log.log, name)
      log.log = name
      log.save
    end
  end

  def self.down
  end
end
