source 'https://rubygems.org'

# Declare your gem's dependencies in cache_machine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "default"
 ">= 4.2.0"
else
 "~> #{rails_version}"
end

gem "rails", rails
gem "redis"
gem "redis-namespace"

gem 'test_after_commit', :group => :test
gem 'simplecov', :group => :test