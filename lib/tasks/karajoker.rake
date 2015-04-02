namespace :karajoker do

  desc "Show Logs"
  task show_logs: :environment do
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO
    Rails.logger = logger
  end

  desc "Index top 100 youtube karaokes"
  task :index_karaokes, [:top] => [:show_logs] do |task, args|
    Karajoker::Job::KaraokeIndexer.new(args.top.to_i).start
  end
end
