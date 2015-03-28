require'nokogiri'

module Karajoker::Crawler
  class BillboardSongHotCharts

    def songs(filters)
      songs = items.inject([]) { |a, e| a << new_song(e) }
      songs.take(filters[:top])
    end

    def initialize
      @page = Nokogiri::HTML(open(URL))
    end

    private

    def items
      @page.css('div[class=row-title]')
    end

    def title(item)
      item.children.css('h2').children.to_s.strip
    end

    def author(item)
      item.children.css('h3').css('a').children.to_s.strip
    end

    def new_song(item)
      Song.new(title(item), author(item))
    end

    URL = "http://www.billboard.com/charts/hot-100"

  end
end
