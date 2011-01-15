# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Auctioneer::Application.load_tasks

require 'auction_parser'
namespace :utils do
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

namespace :logs do
  task :process do
    logs = HTTParty.get('http://auction.goonquest.com/logs')
    logs.each do |log|
      _l = log['log']
      next if _l['processed']
      file = HTTParty.get("http://auction.goonquest.com#{_l['public_path']}")
      puts "processing #{_l['public_path']}"
      p = AuctionParser.from_upload(file)
      p.run_fork
    end
  end
end