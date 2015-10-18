module Service
  class KaraokeCreate
    def call(songs)
      logger = KaraokeCreateLogger.new
      songs.each do |song|
        logger.next_song(song, songs)
        index(song, logger)
      end
      KaraokeCreateResponse.new(logger.indexed)
    end

    private

    def index(song, logger)
      karaoke = Youtube::KaraokeSearcher.new.search("#{song.title} #{song.author}").first
      if karaoke.nil?
        logger.not_found
      elsif  Karaoke.exists?(youtube_id: karaoke.id)
        logger.already_exists
      else
        Karaoke.create_from(year: song.year, author: song.author, title: song.title, youtube_id: karaoke.id)
        logger.indexed
      end
    end
  end
end
