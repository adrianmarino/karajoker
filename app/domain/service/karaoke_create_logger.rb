module Service
  class KaraokeCreateLogger
    def initialize
      @count = 0
      @logger = Rails.logger
    end

    def setup_for(songs, song)
      @count += 1
      @log_prefix = "[#{@count}/#{songs.size}]"
      @log_postfix = "'#{song.title}' (#{song.author})"
    end

    def info(message)
      @logger.info "#{@log_prefix} #{message}: #{@log_postfix}"
    end

    def already_exists
      @logger.info 'Already exists'
    end

    def not_found
      @logger.info 'Not found'
    end

    def indexed
      @logger.info '#Indexed(#{@indexed})'
    end
  end
end
