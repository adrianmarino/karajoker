module Karajoker::Job
  class KaraokeIndexer
    Logger = Karajoker::Util::ActiveRecordLogger

    def start
      Logger.disable
      songs = @crawler.songs(top: @top_count)
      log_top songs

      count = @service.call(songs)
      log_new_karaokes count

      Logger.enable
      true
    ensure
      false
    end

    private

    def log_new_karaokes(count)
      Rails.logger.info "#{count} new karaokes!"
    end

    def log_top(songs)
      songs.each {|song| Rails.logger.info "Song: '#{song}'"}
    end

    def setup_top
      if top_count.nil? || top_count == 0
        @top_count = 100
      else
        @top_count = top_count
      end
      Rails.logger.info "Top: #{@top_count}"
    end

    def initialize(top_count)
      @service = Karajoker::Service::KaraokeCreate.new
      @crawler = Karajoker::Crawler::BillboardSongHotCharts.new
      setup_top top_count
    end
  end
end
