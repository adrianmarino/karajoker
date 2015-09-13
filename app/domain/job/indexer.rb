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

      songs = filter_repeated(response.songs)
      songs = filter_already_indexed(songs)

      logger.info "<< Find & index karaokes for #{songs.size} songs >>"
      response = Service::KaraokeCreate.new.call(songs)

      logger.info "#{response.count} new karaokes for #{year} year!"
    end

    def filter_repeated(songs)
      titles = []
      result = songs.select do |song|
        if titles.include?(song.title)
          false
        else
          titles << song.title
          true
        end
      end
      filtered = songs.size - result.size
      logger.info "<< Filter #{filtered} repeated songs of #{songs.size} >>"
      result
    end

    def filter_already_indexed(songs)
      result = songs.reject { |song| Karaoke.exists?(title: song.title) }
      filtered = songs.size - result.size
      logger.info "<< #{filtered} of #{songs.size} already indexed >>"
      result
    end

    def resolve(years)
      RangeUtils.from(years) || Crawler::Official::Chart.years
    end

    def log_args(limit, years)
      logger.info "Arguments: Get #{limit} song/s per chart between #{years}"
    end
  end
end
