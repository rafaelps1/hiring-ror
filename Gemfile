source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

gem 'rails', '~> 7.0.4', '>= 7.0.4.3'
gem 'puma', '~> 5.0'
gem 'jbuilder'
gem 'mysql2'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false
gem 'rack-cors'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt', '~> 2.7'

group :development, :test do
  gem 'dotenv'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker', '~> 3.2'
  gem 'guard-rspec'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 5.3'
end

group :development do
  gem 'brakeman'
end

group :rubocop do
  gem 'rubocop',             require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails',       require: false
  gem 'rubocop-rspec',       require: false
end
