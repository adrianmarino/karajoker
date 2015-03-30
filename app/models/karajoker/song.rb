module Karajoker
  class Song
    attr_reader :title, :author

    def initialize(title, author)
      @title = title
      @author = author
    end

    def to_s
      "Title: #{title}, Author: #{author}"
    end
  end
end
