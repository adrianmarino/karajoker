namespace :karajoker do
  desc 'Setup Logger'
  task setup_logger: :environment do
    Rails.logger = Karajoker::LoggerConfig.setup(Logger.new(STDOUT))
  end

  desc 'Index new karaokes using BillboardSongHotCharts'
  task :index_karaokes, [:limit, :years] => [:setup_logger] do |task, args|
    limit = args.limit.to_i unless args.limit.nil?
    years = Karajoker::RangeUtils.from(args.years) unless args.years.nil?
    Rails.logger.info "Years: #{years}, Limit: #{limit}"
    Karajoker::Job::KaraokeIndexer.new(limit: limit, years: years).start
  end

  desc 'generate html rubocop report'
  task :rubocop do
    `rubocop -D --format html -o rubocop.html`
    `chromium rubocop.html`
  end

  desc "Show DB config"
  task :db do
    puts "\n\s==========================="
    puts "\s\sDB Config"
    puts "\s==========================="
    puts "\s\s-\sHostname: #{ENV['DB_HOSTNAME']}"
    puts "\s\s-\sUsername: #{ENV['DB_USERNAME']}"
    puts "\s\s-\sPassword: #{ENV['DB_PASSWORD']}"
    puts "\s==========================="
  end
end
