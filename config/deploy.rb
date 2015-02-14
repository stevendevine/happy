# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'happy'
set :repo_url, 'git@github.com:stevendevine/happy.git'
set :deploy_to, "/home/tree/public/happy"
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

namespace :deploy do  

  desc 'Make artisan executable'
  task :artisan do
    on roles(:app), in: :sequence, wait: 5 do
      execute :chmod, "u+x artisan"  
    end
  end

  desc 'Run migrations (if applicable)'
  task :migrate do
    on roles(:app), in: :sequence, wait: 5 do
      execute "php artisan migrate"  
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo service php5-fpm restart"  
    end
  end

  after :deploy, :artisan
  after :deploy, :migrate
  after :deploy, :restart

end
