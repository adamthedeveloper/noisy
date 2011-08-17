require 'yaml'
require 'bundler/capistrano'

set :rvm_type, :user
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2-p290@noisebytes'

# User
#set :user, "user"
set :use_sudo, false

# Options
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# Repo Info
#set :repository, "git@github.com:adamthedeveloper/noisy.git"
set :repository, "git@scarythings.unfuddle.com:scarythings/noisy.git"
set :branch, "master"

# Application Info
set :application, "Noisy"

# Version Control
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_verbose, true
set :scm_username, "webuser"
set :scm_passphrase, "apFHY1"
set :scm_command, "/usr/local/bin/git"

# Notes from help.github.com/capistrano
# Remote Cache In most cases you want to use this option, otherwise each deploy will do a full repository clone everytime
#set :deploy_via, :remote_cache
set :deploy_to, "/Users/user/apps/Noisy"



# Servers
task :local do
	role :web, "127.0.0.1"                          # Your HTTP server, Apache/etc
	role :app, "127.0.0.1"                          # This may be the same as your `Web` server
	role :db,  "127.0.0.1", :primary => true # This is where Rails migrations will run
	#role :db,  "your slave db-server here"
end

task :prod do
	role :web, "74.50.50.135"
	role :app, "74.50.50.135"
	role :db, "74.50.50.135", :primary => true
	set :user, "webuser"
	set :deploy_to, "/var/noisebytes/production"
	set :scm_command, "/usr/bin/git"
    set :unicorn_config, "production_1.rb"
    set :unicorn_host, "127.0.0.1:8080"
    set :config_folder, "production"
    set :rails_environment, "production"
end

task :stage do
	role :web, "74.50.50.135"
	role :app, "74.50.50.135"
	role :db, "74.50.50.135", :primary => true
	set :user, "webuser"
	set :deploy_to, "/var/noisebytes/stage"
    set :unicorn_config, "stage_1.rb"
    set :unicorn_host, "127.0.0.1:9090"
    set :rails_environment, "production"
    set :config_folder, "stage"
	set :scm_command, "/usr/bin/git"
end

task :dev do
	role :web, "74.50.50.135"
	role :app, "74.50.50.135"
	role :db, "74.50.50.135", :primary => true
	set :user, "webuser"
	set :deploy_to, "/var/noisebytes/dev"
    set :unicorn_config, "dev_1.rb"
    set :unicorn_host, "127.0.0.1:9190"
    set :rails_environment, "development"
    set :config_folder, "dev"
	set :scm_command, "/usr/bin/git"
end

# Bundler
#namespace :bundle do
#  task :install, :roles => :app do
#    run("cd #{current_release} && bundle install")
#  end
#  task :update, :roles => :app do
#    run("cd #{current_release} && bundle update")
#  end
#end

#after 'deploy:update', 'bundle:update'
before 'bundle:update','deploy:set_env_vars'
after 'deploy:update', 'deploy:copy_configs'
after 'deploy:copy_configs', 'deploy:permissions'
after 'deploy:copy_configs', 'deploy:migrate'
after 'deploy:restart', 'deploy:nginx:restart'

namespace :deploy do
  task :set_env_vars, :roles => :app do
    run("export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8")
  end
  task :migrate, :roles => :app do
    run("cd #{current_release} && rake db:migrate")
  end
  task :copy_configs, :roles => :web do
    run("cd #{current_release}/config && cp /home/webuser/noisebytes/config/#{config_folder}/database.yml .")
  end
  task :permissions, :roles => :web do
    run("chown -R #{user}:#{user} #{current_release}")
    run("chmod -R 766 #{current_release}/log")
  end
  task :start, :roles => :web do
    run("cd #{current_release} && unicorn_rails -c #{current_release}/config/unicorn/#{unicorn_config} -l #{unicorn_host} -E #{rails_environment} -D")
  end

  task :stop, :roles => :web do
    run("kill -QUIT `ps -ef | grep unicorn | grep master | grep '#{unicorn_host}' | awk '{print $2}'` && rm -rf #{current_release}/tmp/pids")
  end

  task :restart, :roles => :web do
    puts "*"*50
    puts "Restarting Unicorns..."
    deploy.stop
    deploy.start
    puts "Done"
    puts "*"*50
  end

  namespace :nginx do
    task :start, :roles => :web do
      sudo("/usr/sbin/nginx -c /usr/local/nginx/conf/nginx.conf")
#      sudo("/etc/init.d/nginx start")
    end

    task :stop, :roles => :web do
      sudo("x=`ps -ef | grep 'nginx' | grep 'master' | awk '{print $2}'`; if [ \"$x\" ]; then kill $x; fi")
#      sudo("/etc/init.d/nginx stop")
    end

    task :restart, :roles => :web do
      nginx.stop
      nginx.start
#      sudo("/etc/init.d/nginx restart")
    end
  end

  task :hot do
    puts "*"*50
    puts "Doing a hot deploy..."
    deploy.update
    commands = <<-SH
      cd #{current_release} && \
      unicorn_rails -c #{current_release}/config/unicorn/production_2.rb -l 127.0.0.1:9090 -E production -D && \
      echo "reroute" > #{current_release}/public/system/reroute.txt && \
      kill -QUIT `ps -ef | grep unicorn | grep master | grep "127.0.0.1:8080" | awk '{print $2}'` && \
      unicorn_rails -c #{current_release}/config/unicorn/production_1.rb -l 127.0.0.1:8080 -E production -D && \
      kill -QUIT `ps -ef | grep unicorn | grep master | grep "127.0.0.1:9090" | awk '{print $2}'` && \
      rm #{current_release}/public/system/reroute.txt
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
