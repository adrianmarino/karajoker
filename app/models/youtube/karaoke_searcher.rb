module Youtube
  class KaraokeSearcher
    def search(options)
      options[:query] = "#{options[:query]} karaoke"
      @client.videos_by(options).videos.map { |video| KaraokeResult.new video }
    end

    def initialize
      @client = YouTubeIt::Client.new # dev_key: Settings.youtube.dev_key
    end
  end
end
