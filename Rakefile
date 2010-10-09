# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


namespace :custom do
  task :clean_up => :environment do
    regex = Regexp.new("\s(#{AuctionParser::COMMON_BAD_WORDS.join('|')})\s")
    puts regex
    Item.all.each do |i|
      if i.name.scan(regex).size > 0
        puts "cleaning #{i.name}"
        i.hidden = true;
        i.save
      end
    end
  end
end