class Log < ActiveRecord::Base
  validates_presence_of :ip_address, :log
end
