load 'deploy' if respond_to?(:namespace) # cap2 differentiator
set :application, "auction"
set :repository,  "git@github.com:jetviper21/auctioneer.git"

set :scm, :git

role :web, "t.goonquest.com"
set :user, "root"
set :use_sudo, false
set :deploy_to, "/var/www/auction"
set :db, 'localhost'

task :change_params do
 run "chmod -R 0775 #{deploy_to}"
 run "cown -R www-data:www-data #{deploy_to}"
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
