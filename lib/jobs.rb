require 'rubygems'
require 'active_record'
require 'mysql'
RAILS_ENV = ENV["RAILS_ENV"] || "development"
dir = File.join(File.dirname(File.expand_path(__FILE__)))
config = YAML.load_file(File.join(dir, '..', 'config', 'database.yml'))[RAILS_ENV]
config[:adapter] = 'mysql'
ActiveRecord::Base.establish_connection(config)

require File.join(dir, 'auction_parser')
require 'stalker'

Dir["#{File.join(dir, '..', 'app', 'models')}/*.rb"].each do |model|
  require model
end
include Stalker

job 'log.process' do |args|
  log_file = args['log']
  log_id = args['id']
  parser = AuctionParser.new(log_file)
  parser.go!
  parser = nil
  l = Log.find(log_id)
  l.procesed = true
  l.save
end