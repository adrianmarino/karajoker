module Karajoker::Youtube
  class KaraokeResult
    attr_reader :video

    def to_s
      "{'id': #{id}, title': '#{title}', 'author': '#{author}'}"
    end

    def karaoke?
      title.downcase.include? 'karaoke'
    end

    def title
      @video.title
    end

    def author
      @video.author.name
    end

    def id
      @video.unique_id
    end

    def initialize(video)
      @video = video
    end

  end
end
