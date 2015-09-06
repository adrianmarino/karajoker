module Service
  class KaraokeCreate < Base
    def call(songs)
      count = 0
      indexed = songs.inject(0) do |indexed, song|
        count += 1
        log_prefix = "[#{count}/#{songs.size}]"
        log_postfix = "'#{song.title}' (#{song.author})"
        karaoke = search_karaoke(song)
        if karaoke.nil?
          logger.info "#{log_prefix} Not found: #{log_postfix}"
          indexed
        else
          index(karaoke, song, indexed, log_prefix, log_postfix)
        end
      end
      KaraokeCreateResponse.new(indexed)
    end

    private

    def search_karaoke(song)
      result = Youtube::KaraokeSearcher.new.search(query_from(song))
      result.find(&:karaoke?)
    end

    def already_exist?(karaoke)
      Karaoke.exists? youtube_id: karaoke.id
    end

    def query_from(song)
      { query: "#{song.title} #{song.author}" }
    end

    def index(karaoke, song, indexed, log_prefix, log_postfix)
      if already_exist?(karaoke)
        logger.info "#{log_prefix} Already exists: #{log_postfix}"
      else
        Karaoke.create_from(year: song.year, author: song.author, title: song.title, youtube_id: karaoke.id)
        indexed += 1
        logger.info "#{log_prefix} Indexed(#{indexed}): #{log_postfix}"
      end
      indexed
    end
  end
end
