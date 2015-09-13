module Service
  class KaraokeCreate < Base
    
    attr_reader :logger

    def initialize
      @logger = KaraokeCreateLogger.new
      @indexed = 0
    end

    def call(songs)
      songs.each do |song|
        logger.setup_for(songs, song)
        karaoke = search_karaoke(song)
        index(karaoke, song) if karaoke
      end
      KaraokeCreateResponse.new(@indexed)
    end

    private

    def search_karaoke(song)
      karaoke = Youtube::KaraokeSearcher.new.search(query: "#{song.title} #{song.author}").find(&:karaoke?)
      if karaoke.nil?
        logger.not_found
        return nil
      elsif already_exist?(karaoke)
        logger.already_exists
        return nil
      end
      karaoke
    end

    def already_exist?(karaoke)
      Karaoke.exists?(youtube_id: karaoke.id)
    end

    def index(karaoke, song)
      Karaoke.create_from(year: song.year, author: song.author, title: song.title, youtube_id: karaoke.id)
      @indexed += 1
      logger.indexed
    end
  end
end

