module Youtube
  class KaraokeSearcher
    def search(options)
      results = []
      @client.search(query_karaoke(options)) do |video|
        results << KaraokeResult.new(video)
      end
      results
    end

    private

    def query_karaoke(options)
      { query: "#{options[:query]} karaoke" }
    end

    def initialize
      @client = Yourub::Client.new
    end
  end
end
