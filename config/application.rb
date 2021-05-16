require_relative 'boot'

require 'rails/all'
require 'rack/cors'
require 'csv'
# require 'raven'
#
# Raven.configure do |config|
#   config.dsn = 'https://18351b3f8e524adeb86f23663fda8427:88da4c7fb9354362b4766dbd01f5ef5b@sentry.io/1845731'
# end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShiseidoWooBack
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.enable_dependency_loading = true
    # config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')

    config.i18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]

    # config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.eager_load_paths += %w(#{config.root}/app/models/ckeditor)

    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :'zh-CN'
    config.i18n.available_locales = [:'zh-CN']
    # TODO: CORS DOMAIN ISSUE FOR GRAPE
    config.middleware.use Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get,
            :post, :put, :delete, :options]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
