module Karajoker::Job
  class KaraokeIndexer
    include Base
    include Karajoker::Logger

    def run
      @years.to_a.inject(Set.new) do |songs, year|
        logger.info "Year: #{year}"
        response = @service.call(songs(year, @top))
        logger.info "#{response.count} new karaokes for #{year} year!"
      end
    end

    private

    def songs(year, top)
      songs = Karajoker::Crawler::BillboardHotSongsChart.new(year).songs top: top
    end

    def initialize(top, years)
      years = (2006..2015) if years.nil?
      @service = Service::KaraokeCreate.new
      @top = top
      @years = years
    end
  end
end
