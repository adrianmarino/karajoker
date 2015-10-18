module Youtube
  class KaraokeResult
    attr_reader :video

    def to_s
      "{'id': #{id}, title': '#{title}'}"
    end

    def title
      @video['snippet']['title']
    end

    def id
      @video['id']
    end

    def initialize(video)
      @video = video
    end
  end
end
