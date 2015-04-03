namespace :karajoker do

  desc "Setup Logger"
  task setup_logger: :environment do
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO

    logger.formatter = proc do |severity, datetime, progname, message|
      date_format = datetime.strftime("%Y-%m-%d %H:%M:%S:%L")
      "#{date_format} #{severity}: #{message}\n"
    end
    Rails.logger = logger
  end

  desc "Index new karaokes using BillboardSongHotCharts"
  task :index_karaokes, [:top] => [:setup_logger] do |task, args|
    Karajoker::Job::KaraokeIndexer.new(args.top.to_i).start
  end
end
