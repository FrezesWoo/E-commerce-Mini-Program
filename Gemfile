source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2', '>= 5.2.2.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server yes
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Authentification
gem 'devise'

# REST API
gem 'grape'
gem 'grape-active_model_serializers'
gem 'rack-cors', :require => 'rack/cors'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'grape-entity'
gem 'multi_xml'
# gem 'rack-attack'

gem 'dotenv-rails'

gem "paperclip"
gem 'paperclip-storage-aliyun'
gem 'paperclip-azure'
# gem 'paperclip-azure', git: "https://github.com/31ten/paperclip-azure", branch: "master"

# Multilangual website
gem 'rails-i18n'
gem "globalize", "~> 5.2"

# For wechat payment
gem 'wx_pay'

# For alipay
gem "alipay", "~> 0.15.1"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'pry'
  gem 'selenium-webdriver'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "capistrano", "~> 3.11"
  gem "capistrano3-nginx", "~> 2.1"
  gem "capistrano-rvm", "~> 0.1.2"
  gem "capistrano-bundler", "~> 1.3"
  gem "capistrano3-puma"
  gem "capistrano-rails", "~> 1.4"
  gem 'capistrano-rails-db'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Active records
gem 'active_model_serializers'
gem "will_paginate"

# Make it beautiful and smooth
gem 'bootstrap'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem "jquery-rails"
gem 'popper_js'
gem "cocoon"
gem 'autoprefixer-rails'
gem 'mini_racer', platforms: :ruby
gem 'execjs'
gem 'momentjs-rails'
gem "ckeditor", :git => "https://github.com/galetahub/ckeditor.git"
# gem 'ckeditor'# , github: 'galetahub/ckeditor'
gem 'glyphicons-rails'
gem 'will_paginate-bootstrap'
gem 'dropzonejs-rails'
gem 'rails-erd'
gem 'pickadate-rails'

gem 'rubocop-airbnb'

# asynchronous workers
gem 'sidekiq'
gem "devise-async"
gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
gem 'sidekiq-client-cli'

# Bug tracking /performance
gem "sentry-raven"

# For clean unit test
gem "rspec-rails", "~> 3.8"


gem 'whenever', require: false


gem 'rest-client', '~> 2.0', '>= 2.0.2'

gem 'chartkick'
gem 'highcharts-rails'
gem 'groupdate'

gem 'multi-select-rails'
gem 'chosen-rails'
gem 'jquery-fileupload-rails'

gem "redis", "~> 4.1"
gem "redis-rails", "~> 5.0"
gem "redis-namespace"
