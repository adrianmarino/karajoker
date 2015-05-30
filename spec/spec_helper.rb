ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'lib/rest_test_utils'
require 'vcr'
require 'webmock/rspec'

ActiveRecord::Migration.maintain_test_schema!

real_requests = ENV['REAL_REQUESTS'] || false

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true if real_requests
  c.default_cassette_options = {:record => :new_episodes}
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.mock_with :rspec
  config.expect_with :rspec
  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec/
  config.include FactoryGirl::Syntax::Methods
  config.fuubar_progress_bar_options = { :format => "  (%B) %p%% %a  " }

  config.before(:each) do
    VCR.eject_cassette
  end if real_requests
end
