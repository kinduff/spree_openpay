source 'https://rubygems.org'

gem 'spree', github: 'spree/spree', branch: '3-0-stable'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'

#gem 'spree_i18n', github: 'spree/spree_i18n', branch: '3-0-stable'
gem 'globalize', github: 'globalize/globalize', branch: 'master'

group :test, :development do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'sqlite3'
  gem 'factory_girl'
  gem 'pry'
  gem 'database_cleaner'
  gem 'spork'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'capybara'
  gem 'vcr'
  
  gem 'faraday'
  gem 'faraday_middleware'
  gem 'activemerchant'
  gem 'oj'
  gem 'typhoeus'
  gem 'celluloid'
end

group :test do
  gem 'ffaker'
end

gemspec
