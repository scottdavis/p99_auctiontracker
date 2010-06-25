load 'deploy' if respond_to?(:namespace) # cap2 differentiator
set :application, "auction"
set :repository,  "git@github.com:jetviper21/auctioneer.git"

set :scm, :git

server "t.goonquest.com", :app, :web, :db, :primary => true
set :user, "root"
set :use_sudo, false
set :deploy_to, "/var/www/auction"
set :db, 'localhost'

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :change_params do
   run "chmod -R 0775 #{deploy_to}"
   run "chown -R www-data:www-data #{deploy_to}"
  end
  task :setup_logs do
    run "rm #{deploy_to}/current/log"
    run "mkdir #{deploy_to}/current/log"
    run "mkdir #{deploy_to}/current/public/images/graph"
  end
end

before "deploy:change_params", "deploy:setup_logs"
before "deploy:restart", "deploy:change_params"