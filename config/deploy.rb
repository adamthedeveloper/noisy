set :rvm_type, :user
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2@noisebytes'

# User
#set :user, "user"
set :use_sudo, false

# Options
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# Repo Info
set :repository, "git@github.com:adamthedeveloper/noisy.git"
set :branch, "master"

# Application Info
set :application, "Noisy"

# Version Control
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_verbose, true
set :scm_username, "user"
set :scm_passphrase, "g0bst0pp3r"
set :scm_command, "/opt/local/bin/git"

# Notes from help.github.com/capistrano
# Remote Cache In most cases you want to use this option, otherwise each deploy will do a full repository clone everytime
#set :deploy_via, :remote_cache
set :deploy_to, "/Users/user/apps/Noisy"



# Servers
role :web, "127.0.0.1"                          # Your HTTP server, Apache/etc
role :app, "127.0.0.1"                          # This may be the same as your `Web` server
role :db,  "127.0.0.1", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# Bundler
namespace :bundle do
  task :install, :roles => :app do
    run("cd #{current_release} && bundle install")
  end
end

after 'deploy:update', 'bundle:install'

namespace :deploy do
  task :start do
    run("cd #{current_release} && unicorn_rails -c #{current_release}/config/unicorn/production.rb -l 127.0.0.1:8080 -E production -D")
  end

  task :stop do
    run("kill -QUIT `ps -ef | grep unicorn | grep master | grep '127.0.0.1:8080' | awk '{print $2}'`")
  end

  task :restart do
    puts "*"*50
    puts "Restarting Unicorns..."
    deploy.stop
    deploy.start
    puts "Done"
    puts "*"*50
  end

  namespace :nginx do
    task :start do
      run("/usr/local/nginx/sbin/nginx -c #{current_release}/config/nginx/nginx.conf")
    end

    task :stop do
      run("kill  `ps -ef | grep 'nginx' | grep 'master' | awk '{pring $2}'`")
    end

    task :restart do
      nginx.stop
      nginx.start
    end
  end

  task :hot do
    puts "*"*50
    puts "Doing a hot deploy..."
    deploy.update
    commands = <<-SH
      cd #{current_release} && \
      unicorn_rails -c #{current_release}/config/unicorn/production.rb -l 192.168.1.5:8001 -E production -D && \
      echo "reroute" > public/system/reroute.txt && \
      kill -QUIT `ps -ef | grep unicorn | grep master | grep "127.0.0.1:8080" | awk '{print $2}'` && \
      unicorn_rails -c #{current_release}/config/unicorn/production.rb -l 127.0.0.1:8080 -E production -D && \
      kill -QUIT `ps -ef | grep unicorn | grep master | grep "192.168.1.5:8001" | awk '{print $2}'` && \
      rm public/system/reroute.txt
    SH
    run(commands)
  end
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end