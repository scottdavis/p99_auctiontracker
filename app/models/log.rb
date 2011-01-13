class Log < ActiveRecord::Base
  LOG_PATH = "/system/logs"
  validates_presence_of :ip_address, :log
  
  
  
  def public_path
    "#{LOG_PATH}/#{File.basename(log)}"
  end
  
end
