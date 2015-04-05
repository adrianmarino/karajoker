require'nokogiri'

module Karajoker::Crawler
  class BillboardHotSongsChart
    Song = Karajoker::Entity::Song
    DateUtils = Karajoker::DateUtils

    def songs(top: 100)
      top = 100 if top.nil?
      songs = items.inject([]) { |a, e| a << new_song(e) }
      songs.take(top)
    end

    def initialize(year = DateUtils.current_year)
      @page = Nokogiri::HTML(open(url(year)))
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

    def url(year)
      base = "http://www.billboard.com/charts"
      if DateUtils.current_year == year.to_s
        "#{base}/hot-100"
      else
        "#{base}/year-end/#{year}/hot-100-songs"
      end
    end
  end
end
