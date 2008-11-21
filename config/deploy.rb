set :user, 'justus'
ssh_options[:port] = 2210
default_run_options[:pty] = true
set :scm, :git
set :scm_passphrase, "rosenwel" #This is your custom users password

#ssh_options[:forward_agent] = true
#ssh_options[:paranoid] = false
ssh_options[:port] = 2210

set :branch, "master"

set :application, "crawler"
set :repository,  "git@github.com:ohlhaver/crawler.git"

set :keep_releases, 3 

set :deploy_via, :remote_cache

role :web, '75.126.145.240'
role :app, '75.126.145.240'
role :db,  '75.126.145.240', :primary => true

set :deploy_via, :remote_cache

set :deploy_to, "/home/justus/#{application}"
set :use_sudo, false
task :restart, :roles => :app do
end

task :after_update_code, :roles => [:web, :db, :app] do
  run "chmod 755 #{release_path}/public -R" 
end

task :after_deploy, :roles => [:web] do
    run "sed -e \"s/^# ENV/ENV/\" -i #{release_path}/config/environment.rb"
    run "cd /home/justus/#{application}/current; mongrel_rails cluster::restart"
end

after "deploy", "deploy:cleanup"
