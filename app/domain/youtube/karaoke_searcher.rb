module Youtube
  class KaraokeSearcher
    def search(song)
      results = []
      @client.search(query(song)) { |video| results << KaraokeResult.new(video) if karaoke?(video) }
      results
    end

    private

    def karaoke?(video)
      video['snippet']['title'].downcase.include?('karaoke')
    end

    def query(song)
      { query: "#{song} karaoke" }
    end

    def initialize
      @client = Yourub::Client.new
    end
  end
end
