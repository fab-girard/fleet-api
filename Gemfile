source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'rails-i18n'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Database interface
gem 'libuv', '= 4.0.2' # Force libuv 4.0.2 to build libcouchbase
gem 'couchbase-orm'

# Encrypt password
gem 'bcrypt'

# Serializer
gem 'active_model_serializers'

# HTTP requests
gem 'http'
gem 'rest-client'

# Permission
gem 'pundit'

# Swagger integration
gem 'rspec-rails'
gem 'rswag'

# Use Factory Girl for generating random data
gem 'factory_bot_rails'
gem 'faker'

# SMS
gem 'iso_country_codes'
gem 'phonelib'
gem 'nexmo'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  # Use Puma as the app server
  gem 'puma'

  gem 'rubocop'
  gem 'byebug'
  gem 'i18n-tasks'

  # Debugging tool
  gem 'awesome_print'
  gem 'pry-rails'

  gem 'brakeman'
end

group :test do
  # Use RSpec for specs
  gem 'shoulda-matchers'
  gem 'fuubar'

  gem 'simplecov'
end
