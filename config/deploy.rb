require "bundler/capistrano"

set :application, "Kayak"
set :repository,  "https://github.com/rociiu/demo_app.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/kayak"
set :user, "deploy"
set :scm, :git
set :scm_passphrase, "1ntrid3a"
set :normalize_asset_timestamps, false
set :user_sudo, true

role :web, "kayak.test"                          # Your HTTP server, Apache/etc
role :app, "kayak.test"                          # This may be the same as your `Web` server
role :db,  "kayak.test", :primary => true # This is where Rails migrations will run
role :db,  "kayak.test"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


namespace :unicorn do
  desc "Start unicorn for this application"
  task :start do
    run "cd #{current_path} && bundle exec unicorn -c /etc/unicorn/kayak.conf.rb -D"
  end
end

