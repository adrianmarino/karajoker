module Job
  class KaraokeIndexerWithYearJob
    include Sidekiq::Worker
    include AppLogger
    sidekiq_options retry: true

    def perform(limit, year)
      logger.info "<< Get best songs at #{year} >>"
      response = Service::SongSearch.new.call(year, limit)

      songs = filter_repeated(response.songs)
      songs = filter_already_indexed(songs)

      logger.info "<< Find & index karaokes for #{songs.size} songs >>"
      response = Service::KaraokeCreate.new.call(songs)

      logger.info "#{response.count} new karaokes for #{year} year!"
    end

    def filter_repeated(songs)
      result = songs.uniq(&title)
      logger.info "<< Filter #{songs.size - result.size} repeated songs of #{songs.size} >>"
      result
    end

    def filter_already_indexed(songs)
      result = songs.reject { |song| Karaoke.exists?(title: song.title) }
      logger.info "<< #{songs.size - result.size} of #{songs.size} already indexed >>"
      result
    end
  end
end
