#!/usr/bin/env rake
require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks

unless Rails.env.production?
  require 'rubocop/rake_task'
  require 'rspec/core/rake_task'

  Rake::Task[:default].prerequisites.clear
  RSpec::Core::RakeTask.new(:test) { |spec| spec.pattern = FileList['spec/**/*_spec.rb'] }
  RuboCop::RakeTask.new(:rubocop)

  task default: [:test, :rubocop]
end
