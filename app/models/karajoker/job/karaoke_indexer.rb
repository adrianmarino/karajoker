module Karajoker
  module Job
    class KaraokeIndexer
      def start
        Karajoker::Util::ActiveRecordLogger.disable
        songs = @crawler.songs(top: @top_count)
        log_top songs

        count = @service.call(songs)
        log_new_karaokes count

        Karajoker::Util::ActiveRecordLogger.enable
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

      def disable_logs
        @old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
      end

      def enable_logs
        ActiveRecord::Base.logger = @old_logger
      end

      def initialize(top_count)
        @service = Karajoker::Service::KaraokeCreate.new
        @crawler = Karajoker::Crawler::BillboardSongHotCharts.new

        if top_count.nil? || top_count == 0
          @top_count = 100
        else
          @top_count = top_count
        end
        Rails.logger.info "Top: #{@top_count}"
      end
    end
  end
end
