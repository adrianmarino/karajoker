ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'rest_test_utils'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
	config.use_transactional_fixtures = true
  config.mock_with :rspec
  config.expect_with :rspec
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec/
	config.include FactoryGirl::Syntax::Methods
end

