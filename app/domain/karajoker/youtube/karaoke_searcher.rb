module Karajoker::Youtube
  class KaraokeSearcher
    def search(options)
      result = @client.videos_by query_karaoke(options)
      to_karaoke_result result.videos
    end

    private
    def to_karaoke_result(videos)
      videos.map { |video| KaraokeResult.new video }
    end

    def query_karaoke(options)
      { query: "#{options[:query]} karaoke" }
    end

    def initialize
      @client = YouTubeIt::Client.new # dev_key: Settings.youtube.dev_key
    end
  end
end
