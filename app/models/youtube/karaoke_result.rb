module Youtube
  class KaraokeResult
    attr_reader :video

    def equal?(obj)
      title.equal?(obj.title) & author.equal?(obj.author)
    end

    def to_s
      "#{title} / #{author}"
    end

    def title
      @video.title
    end

    def author
      @video.author.name
    end

    def initialize(video)
      @video = video
    end

  end
end
