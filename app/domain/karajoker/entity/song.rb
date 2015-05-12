module Karajoker::Entity
  class Song
    attr_reader :year, :title, :author

    def initialize(year, title, author)
      @year = year
      @title = title.humanize
      @author = author.humanize
    end

    def to_s
      "{'year': #{year}, 'title': '#{title}', 'author': '#{author}'}"
    end
  end
end
