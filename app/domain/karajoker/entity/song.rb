module Karajoker::Entity
  class Song
    attr_reader :title, :author

    def initialize(title, author)
      @title = title
      @author = author
    end

    def to_s
      "{'title': '#{title}', 'author': '#{author}'}"
    end
  end
end
