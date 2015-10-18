module Service
  class KaraokeCreateLogger
    include AppLogger

    attr_reader :indexed

    def initialize
      @count = @indexed = 0
    end

    def next_song(song, songs)
      @count += 1
      @prefix = "[#{@count}/#{songs.size}]"
      @postfix = "'#{song.title}' (#{song.author})"
    end

    def not_found
      logger.info "#{@log_prefix} Not found: #{@log_postfix}"
    end

    def already_exists
      logger.info "#{@log_prefix} Already exists: #{@log_postfix}"
    end

    def indexed
      @indexed += 1
      logger.info "#{@log_prefix} Indexed(#{@indexed}): #{@log_postfix}"
    end
  end
end
