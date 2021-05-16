set :branch, 'develop'
set :env, 'staging'
set :rails_env, 'testing'
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:application)}"

server 'shiseido-ecmp.31ten.cn', user: 'deployer', roles: %w{web app db}, port: 22
