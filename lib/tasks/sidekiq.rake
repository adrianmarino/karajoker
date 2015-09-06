namespace :sidekiq do
  desc 'Start sidekiq worker'
  task :start => 'redis:start' do
    `bin/bundle exec sidekiq -C config/sidekiq.yml`
  end
end
