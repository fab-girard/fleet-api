require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
# require "active_record/railtie"
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MapotempoFleet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Application config
    config.middleware.use Rack::Config do |env|
      env['api.tilt.root'] = Rails.root.join 'app', 'api', 'views'
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete, :patch]
      end
    end

    # Json adapter for serializers
    # config.autoload_paths += %W(#{config.root}/app/controllers/api/v01/helpers)
    config.paths.add 'app/controllers/api/v01/helpers', eager_load: true
    config.paths.add 'app/serializers', eager_load: true
    ActiveModel::Serializer.config.adapter = :json
    ActiveModel::Serializer.config.default_includes = '**'

    # Load lib directory
    config.enable_dependency_loading = true
    config.autoload_paths += Dir["#{Rails.root.join('lib')}/**/"]

    # Swagger configuration
    config.x.swagger_docs_base_path = 'http://localhost:3000/'
    config.x.api_contact_email = 'tech@mapotempo.com'
    config.x.api_contact_url = 'https://github.com/Mapotempo/fleet-api'

    config.sms_api_key = 'my_api_key'
    config.sms_api_secret = 'my_api_secret'

    def cache_factory(namespace, expires_in)
      ActiveSupport::Cache::FileStore.new(File.join(Dir.tmpdir, namespace), namespace: namespace, expires_in: expires_in)
    end
    require './lib/routers/router_wrapper.rb'

    config.router_api_key = 'demo'
    config.router_url = 'http://localhost:4899'
    config.router = Routers::RouterWrapper.new(cache_factory('router_wrapper_request', 60*60*24*1), cache_factory('router_wrapper_result', 60*60*24*1), config.router_api_key)
  end
end
