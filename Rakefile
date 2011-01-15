# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Auctioneer::Application.load_tasks

require 'auction_parser'
namespace :utils do
  task :clean_items => [:environment] do
    require 'yaml'
    fake_items = YAML.load_file(Rails.root.join('db', 'fake_items.yaml'))
    puts Item.not_hidden.count
    fake_items.each do |hash|
      puts "Looking for #{hash['item']}"
      item = Item.find_by_name(hash['item'].strip)
      unless item.nil?
        item.hide!
        puts "hiding item"
      end
    end
    puts Item.not_hidden.count
  end
  task :to_haml do
    class ToHaml
      def initialize(path)
        @path = path
      end

      def convert!
        Dir["#{@path}/**/*.erb"].each do |file|
          `html2haml -rx #{file} #{file.gsub(/\.erb$/, '.haml')}`
          `rm #{file}`
        end
      end
    end
    path = Rails.root.join('app', 'views')
    ToHaml.new(path).convert!
  end
  
end