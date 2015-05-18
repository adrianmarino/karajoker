require'nokogiri'

module Karajoker::Crawler
  class BillboardHotSongsChart
    Song = Karajoker::Entity::Song

    def songs(top: 100)
      top = 100 if top.nil?
      songs = items.inject([]) { |a, e| a << new_song(e) }
      songs.take(top)
    end

    def initialize(year = Date.current.year)
      @year = year
      @page = Nokogiri::HTML(open(url(@year)))
    end

    private

    def items
      @page.css('div[class=row-title]')
    end

    def title(item)
      item.children.css('h2').children.to_s.strip.humanize
    end

    def author(item)
      item.children.css('h3').css('a').children.to_s.strip.humanize
    end

    def new_song(item)
      Song.new(@year, title(item), author(item))
    end

    def url(year)
      if Date.current.year == year
        "#{URL}/hot-100"
      else
        "#{URL}/year-end/#{year}/hot-100-songs"
      end
    end

    URL = 'http://www.billboard.com/charts'
  end
end
