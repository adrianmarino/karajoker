module Karajoker::Crawler::Billboard
  class HotChart
    Song = Karajoker::Entity::Song

    def songs(limit: 100)
      return [] unless any_songs_at?(@year)

      limit = 100 unless limit.present?
      items.take(limit).inject([]) { |a, e| a << new_song(e) }
    end

    def initialize(year = Time.zone.today.year)
      @year = year
      @page = Nokogiri::HTML(open(url(@year))) if any_songs_at?(@year)
    end

    private

    def any_songs_at?(year)
      (2006..2015).include? year
    end

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
      if Time.zone.today.year == year
        "#{URL}/hot-100"
      else
        "#{URL}/year-end/#{year}/hot-100-songs"
      end
    end

    URL = 'http://www.billboard.com/charts'
  end
end
