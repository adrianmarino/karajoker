namespace :karajoker do
  desc "Setup Logger"
  task setup_logger: :environment do
    Rails.logger = Karajoker::LoggerConfig.setup(Logger.new(STDOUT))
  end

  desc "Index new karaokes using BillboardSongHotCharts"
  task :index_karaokes, [:top] => [:setup_logger] do |task, args|
    Karajoker::Job::KaraokeIndexer.new(args.top.to_i).start
  end
end
