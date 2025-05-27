source "https://rubygems.org"

gem "annotate"
gem 'active_model_serializers'
gem "bootsnap", require: false
gem "devise"
gem "happy_gemfile"
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "pry-rails"
gem "puma", ">= 5.0"
gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "rack-cors"
gem "rufo"
gem "solargraph"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
  gem "ffaker"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov"
  gem "shoulda-matchers"
end

gem "rubocop", "~> 1.75", :groups => [:development, :test]
