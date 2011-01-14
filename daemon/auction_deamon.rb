require 'rubygems'
require 'httparty'
require 'geo_ip'

class AuctionDeamon
  attr_accessor :log_data
  LOGS_URL = 'http://auction.goonquest.com/logs?processed=false'
  DOWNLOAD_PREFIX = 'http://auction.goonquest.com'
  GEO_IP_KEY = '3bdd98f47048717f83099c7a4d529e904512b23df3bfe4ee17fdaa73ba611546'
  TMP_DIR = '/tmp'
  @log_data = []
  @pending_files = []
  
  def self.fetch_new_logs_and_process
    fetch_logs_if_new
    download_logs
  end
  
  def self.fetch_logs_if_new
    logs = HTTParty.get(LOGS_URL)
    @log_data = [] if logs.empty?
    @log_data = logs.parsed_response
  end
  
  def self.download_logs
    @log_data.each do |log|
      l = log['log']
      req = HTTParty.get("#{DOWNLOAD_PREFIX}/#{l['public_path']}") 
      file = File.join(TMP_DIR, File.basename(l['public_path']))
      File.open(file, "w") do |f|
        f << req.response
      end
      @pending_files << file
    end
  end
  
  
end
