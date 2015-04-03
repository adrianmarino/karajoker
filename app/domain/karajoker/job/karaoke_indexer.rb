module Karajoker::Job
  class KaraokeIndexer
    include Karajoker::Util::ActiveRecordLogger
    Logger = Rails.logger

    def start
      disable_active_record_logger
      songs = @crawler.songs(top: @top_count)
      log_top songs

      count = @service.call(songs)
      log_new_karaokes count

      enable_active_record_logger
      true
    ensure
      false
    end

    private

    def log_new_karaokes(count)
      Logger.info "#{count} new karaokes!"
    end

    def log_top(songs)
      songs.each {|song| Logger.info "Song: '#{song}'"}
    end

    def setup_top(top_count)
      if top_count.nil? || top_count == 0
        @top_count = 100
      else
        @top_count = top_count
      end
      Logger.info "Top: #{@top_count}"
    end

    def initialize(top_count)
      @service = Karajoker::Service::KaraokeCreate.new
      @crawler = Karajoker::Crawler::BillboardSongHotCharts.new
      setup_top top_count
    end
  end
end
