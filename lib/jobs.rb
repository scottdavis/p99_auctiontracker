require 'rubygems'
require 'active_record'
require 'mysql2'
RAILS_ENV = ENV["RAILS_ENV"] || "development"
dir = File.join(File.dirname(File.expand_path(__FILE__)))
config = YAML.load_file(File.join(dir, '..', 'config', 'database.yml'))[RAILS_ENV]
puts config.inspect
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
end