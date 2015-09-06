module Job
  class Indexer
    include Sidekiq::Worker
    include AppLogger

    sidekiq_options retry: false

    def perform(limit, years)
      years = resolve(years)
      log_args(limit, years)
      years.each { |year| find_and_index(limit, year) }
    end

    private

    def find_and_index(limit, year)
      logger.info "<< Get best songs at #{year} >>"
      response = Service::SongSearch.new.call(year, limit)

      logger.info "<< Find & index karaokes for #{response.songs.size} songs >>"
      response = Service::KaraokeCreate.new.call(response.songs)
      logger.info "#{response.count} new karaokes for #{year} year!"
    end

    def resolve(years)
      RangeUtils.from(years) || Crawler::Official::Chart.years
    end

    def log_args(limit, years)
      logger.info "Arguments: Get #{limit} song/s per chart between #{years}"
    end
  end
end
