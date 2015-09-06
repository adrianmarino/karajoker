namespace :karajoker do
  desc 'Index top songs from year'
  task :index, [:limit, :years, :port] do |task, args|
    require File.expand_path('../../../config/environment', __FILE__)
    limit = args.limit || '10'
    years = RangeUtils.from(args.years) || (Time.zone.today.year..Time.zone.today.year)
    port  = args.port || '8081'

    years.to_a.each do |year|
      puts "Index first #{limit} top songs at #{year}"
      url = "http://localhost:#{port}/api/index"
      RestClient.post(url, { limit: limit, years: years }.to_json, content_type: :json, accept: :json)
    end
  end

  desc 'Show db info'
  task :dbinfo do
    puts "\n\s==========================="
    puts "\s\sDB Config"
    puts "\s==========================="
    puts "\s\s-\sHostname: #{ENV['DB_HOSTNAME']}"
    puts "\s\s-\sUsername: #{ENV['DB_USERNAME']}"
    puts "\s\s-\sPassword: #{ENV['DB_PASSWORD']}"
    puts "\s==========================="
  end
end
