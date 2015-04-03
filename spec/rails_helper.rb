require 'rubygems'

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

require 'capybara/rspec'

require 'lib/rest_test_utils'
