module Karajoker::Youtube
  class KaraokeResult
    attr_reader :video

    def to_s
      "{'id': #{id}, title': '#{title}'}"
    end

    def karaoke?
      title.downcase.include? 'karaoke'
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
