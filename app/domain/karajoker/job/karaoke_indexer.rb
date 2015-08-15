Chart = Karajoker::Crawler::Official::Chart
Service = Karajoker::Service

module Karajoker::Job
  class KaraokeIndexer
    include Base
    include Karajoker::Logger

    def run
      logger.info "Years: #{@years}"
      @years.to_a.each do |year|
        logger.info "Year: #{year}"
        response = Service::SongSearch.new.call(year, @limit)

        response = Service::KaraokeCreate.new.call(response.songs)
        logger.info "#{response.count} new karaokes for #{year} year!"
      end
    end

    def initialize(limit: nil, years: nil)
      @limit = limit
      @years = years || Chart.years
    end
  end
end
