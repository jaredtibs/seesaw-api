source 'https://rubygems.org'

ruby "2.3.1"

gem 'active_model_serializers', '~> 0.10.0'
gem 'devise'
gem 'jwt'
gem 'pg'
gem 'puma'
gem 'rack-cors', :require => 'rack/cors'
gem 'rails', '~> 5.0.0'
gem 'redis', '~> 3.0'
gem 'redis-rails'
gem 'sidekiq'
gem 'sidetiq'

group :development, :test do
  gem 'awesome_print'
  gem "better_errors"
  gem 'byebug', platform: :mri
  gem "dotenv-rails"
  gem 'rspec-rails'
end

group :test do
  gem 'factory_girl'
end

group :development do
  gem 'listen', '~> 3.0.5'
end

group :production do
  gem 'rails_12factor'
  gem 'unicorn'
end