namespace :redis do
  desc 'clean redis data'
  task :flush do
    `redis-cli flushdb; redis-cli flushall`
  end

  desc 'Start redis server'
  task :start => :flush do
    system('nohup redis-server &')
  end
end
