ENV["RAILS_ENV"] = "test"

require 'simplecov'
SimpleCov.start

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../dummy/test/fixtures", __FILE__)
end

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.pre_loaded_fixtures = true
  fixtures :all
end