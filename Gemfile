source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.6"

gem "sqlite3", "~> 1.4"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"

group :development, :test do
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
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
