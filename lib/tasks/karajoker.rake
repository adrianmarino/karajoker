namespace :karajoker do
  desc "Setup Logger"
  task setup_logger: :environment do
    Rails.logger = Karajoker::LoggerConfig.setup(Logger.new(STDOUT))
  end

  desc "Index new karaokes using BillboardSongHotCharts"
  task :index_karaokes, [:top, :years] => [:setup_logger] do |task, args|
    top = args.top.to_i unless args.top.nil?
    years = Karajoker::RangeUtils.from(args.years) unless args.years.nil?
    Karajoker::Job::KaraokeIndexer.new(top, years).start
  end
end
