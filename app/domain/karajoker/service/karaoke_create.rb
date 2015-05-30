module Karajoker::Service
  class KaraokeCreate
    include Karajoker::Logger
    KaraokeSearcher = Karajoker::Youtube::KaraokeSearcher
    Karaoke = Karajoker::Entity::Karaoke

    def call(songs)
      count = songs.inject(0) do |counter, song|
        karaoke = search_karaoke(song)
        if karaoke.nil?
          logger.info "\t- Karaoke Not Founded!"
          counter
        else
          index(karaoke, song, counter)
        end
      end
      KaraokeCreateResponse.new(count)
    end

    private

    def search_karaoke(song)
      logger.info "Youtube Search: #{song}"
      result = KaraokeSearcher.new.search(query_from(song))
      result.find(&:karaoke?)
    end

    def already_exist?(karaoke)
      Karaoke.exists? youtube_id: karaoke.id
    end

    def query_from(song)
      { query: "#{song.title} #{song.author}" }
    end

    def index(karaoke, song, create_counter)
      if already_exist?(karaoke)
        logger.info "\t- Karaoke already indexed!"
      else
        logger.info "\t- Index Karaoke!"
        Karaoke.create_from(year: song.year, author: song.author, title: song.title, youtube_id: karaoke.id)
        create_counter += 1
      end
      create_counter
    end
  end
end
