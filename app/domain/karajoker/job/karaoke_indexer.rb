module Karajoker::Job
  class KaraokeIndexer
    include Base
    include Karajoker::Logger

    def run
      @years.to_a.each do |year|
        logger.info "Year: #{year}"
        response = @service.call(songs(year, @limit))
        logger.info "#{response.count} new karaokes for #{year} year!"
      end
    end

    private

    def songs(year, limit)
      Karajoker::Crawler::BillboardHotSongsChart.new(year).songs limit: limit
    end

    def initialize(limit, years)
      years = (2006..2015) if years.nil?
      @service = Service::KaraokeCreate.new
      @limit = limit
      @years = years
    end
  end
end
