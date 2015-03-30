module Karajoker
  module Job
    class YoutubeKaraokeIndexer

      def start
        disable_sql_logs

        songs = @crawler.songs(top: @top_count)
        songs.each {|song| Rails.logger.info "Song: '#{song}'"}

        count = @spider.start(songs)
        Rails.logger.info "#{count} new karaokes!"

        enable_sql_logs
        true
      end

      private

      def disable_sql_logs
        @old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
      end

      def enable_sql_logs
        ActiveRecord::Base.logger = @old_logger
      end

      def initialize(top_count)
        @spider = Karajoker::Youtube::KaraokeYoutubeSpider.new
        @crawler = Karajoker::Crawler::BillboardSongHotCharts.new
        @top_count = top_count
      end
    end
  end
end
