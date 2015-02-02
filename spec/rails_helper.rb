ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'spec_helper'
require 'rspec/rails'
ActiveRecord::Migration.check_pending!
require 'simplecov'
SimpleCov.start 'rails'

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
