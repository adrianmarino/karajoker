ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'lib/rest_test_utils'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.mock_with :rspec
  config.expect_with :rspec
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec/
  config.include FactoryGirl::Syntax::Methods
  config.fuubar_progress_bar_options = { :format => "  (%B) %p%% %a  " }
end
