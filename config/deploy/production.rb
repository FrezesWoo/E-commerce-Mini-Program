set :branch, 'master'
set :env, 'production'
set :rails_env, 'production'
set :deploy_to, "/home/aurelien/apps/#{fetch(:application)}"

role :web, %w{ 10.26.72.106 10.26.72.107 10.26.72.108 10.26.72.109 }, user: 'aurelien', port: 22
role :app, %w{ 10.26.72.106 10.26.72.107 10.26.72.108 10.26.72.109 }, user: 'aurelien', port: 22
role :db, %w{ 10.26.72.106 10.26.72.107 10.26.72.108 10.26.72.109 }, user: 'aurelien', port: 22
