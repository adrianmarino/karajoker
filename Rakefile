#!/usr/bin/env rake
require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks

if Rails.env.test? || Rails.env.development?
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test) do |spec|
    spec.pattern = FileList['spec/model/*_spec.rb','spec/resources/*_spec.rb']
  end

  Rake::Task[:default].prerequisites.clear

  # require 'rubocop/rake_task'
  # RuboCop::RakeTask.new(:rubocop)

  # task default: [:rubocop, :test]
  task default: [:test]
end


namespace :karajoker do
  desc "Create a new schema on MySQL DB"
  task :setup_mysql do
  	`mysql -u root -p < db/setup_mysql.sql`
  end
end