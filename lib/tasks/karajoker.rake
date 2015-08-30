namespace :karajoker do
  desc 'Setup Logger'
  task setup_logger: :environment do
    Rails.logger = Karajoker::LoggerConfig.setup(Logger.new(STDOUT))
  end

  desc 'Index top songs from year'
  task :index, [:limit, :years, :port] => [:setup_logger] do |task, args|
    limit = args.limit || '10'
    years = args.years ? Karajoker::RangeUtils.from(args.years) : Time.zone.today.year..Time.zone.today.year
    port  = args.port || '8081'

    require 'rest-client'
    years.to_a.each do |year|
      puts "Index first #{limit} top songs at #{year}"
      url = "http://localhost:#{port}/api/index"
      RestClient.post(url, { limit: limit, years: years }.to_json, content_type: :json, accept: :json)
    end
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
