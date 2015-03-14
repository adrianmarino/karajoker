#!/usr/bin/env rake
require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks

if Rails.env.test? || Rails.env.development?
  require 'rubocop/rake_task'
  require 'rspec/core/rake_task'

  Rake::Task[:default].prerequisites.clear
  RuboCop::RakeTask.new(:rubocop)
  RSpec::Core::RakeTask.new(:test) do |spec|
    spec.pattern = FileList['spec/**/*_spec.rb']
  end

  task default: [:rubocop, :test]
  task default: [:test]
end

namespace :karajoker do
  desc "Create a new schema on MySQL DB"
  task :setup_mysql do
  	`mysql -u root -p < db/setup_mysql.sql`
  end
end
