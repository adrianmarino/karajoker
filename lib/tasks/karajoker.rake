namespace :karajoker do
  desc "Setup Logger"
  task setup_logger: :environment do
    Rails.logger = Karajoker::LoggerConfig.setup(Logger.new(STDOUT))
  end

  desc "Index new karaokes using BillboardSongHotCharts"
  task :index_karaokes, [:limit, :years] => [:setup_logger] do |task, args|
    limit = args.limit.to_i unless args.limit.nil?
    years = Karajoker::RangeUtils.from(args.years) unless args.years.nil?
    Karajoker::Job::KaraokeIndexer.new(limit, years).start
  end
end
