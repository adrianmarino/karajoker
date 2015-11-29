namespace :docker do
  desc 'Start docker containers'
  task :start do
    `docker-compose up -d`
  end

  desc 'Stop docker containers'
  task :stop do
    `docker-compose stop`
  end

  desc 'Build docker images'
  task :build do
    `docker-compose build`
  end

  desc 'Restart docker containers'
  task :restart do
    Rake::Task['docker:stop'].execute
    Rake::Task['docker:start'].execute
  end
end
