source "https://rubygems.org"

gem "rails", "~> 7.2.1", ">= 7.2.1.1"

gem "sprockets-rails"
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "mongoid", "~> 9.0"
gem "ostruct", "~> 0.6.0"

gem "httparty", "~> 0.22.0"

group :development, :test do
  gem "brakeman", require: false

  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rubocop-rails-omakase", require: false
  gem "dotenv", "~> 3.1"
end

group :development do
  gem "web-console"
end

group :test do
  gem "rspec-rails", "~> 7.0"
  gem "factory_bot_rails", "~> 6.4"
  gem "webmock", "~> 3.24"
end

gem "roo", "~> 2.10"
