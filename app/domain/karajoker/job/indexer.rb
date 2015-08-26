module Karajoker::Job
  class Indexer
    include Sidekiq::Worker
    include Karajoker::Logger

    sidekiq_options retry: false

    def perform(limit, years)
      years = Karajoker::RangeUtils.from(years) unless years.nil?
      years ||= Karajoker::Crawler::Official::Chart.years

      logger.info "Arguments: Get #{limit} song/s per chart between #{years}"
      years.each do |year|
        logger.info "<< Get best songs at #{year} >>"
        response = Karajoker::Service::SongSearch.new.call(year, limit)
        logger.info "<< Find & index karaokes for #{response.songs.size} songs >>"
        response = Karajoker::Service::KaraokeCreate.new.call(response.songs)
        logger.info "#{response.count} new karaokes for #{year} year!"
      end
    end
  end
end
