# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "shiseido-ecmp-back"
set :repo_url, "git@github.com:31ten/shiseido-ecmp-back.git"
# set :repo_url, 'file:///home/ecmp/shiseido-back'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_user, 'deployer'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", ".env", 'config/secrets.yml', 'puma.rb'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

set :rvm1_map_bins, %w{bundle rake rvm puma pumactl npm nvm node sidekiq sidekiqctl}

set :rvm_type, 'deployer'
set :rvm_ruby_version, '2.5.0'

# Defaults to :db role
set :migration_role, :db

set :puma_role, :app

# Defaults to the primary :db server
set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, false

SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "bundle exec sidekiqctl"

set :sidekiq_processes, 9
set :sidekiq_options_per_process, ["--queue critical", "--queue default", "--queue low", "--queue order"]

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do

  after :deploy, "puma:restart"
  after :deploy, "nginx:reload"

end
