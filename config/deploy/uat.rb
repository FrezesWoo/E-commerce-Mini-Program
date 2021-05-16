set :branch, 'uat'
set :env, 'uat'
set :rails_env, 'uat'
set :deploy_to, "/home/aurelien/apps/#{fetch(:application)}"

server '10.26.72.111', user: 'aurelien', roles: %w{web app db}, port: 22
