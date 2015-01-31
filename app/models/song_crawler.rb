require'nokogiri'

class SongCrawler

  def serch(filters)
    top = filters[:top]
    counter = 0
    (@page.css('div[class=row-title]').inject([]) do | songs, an_item |
      title = an_item.children.css('h2').children.to_s.strip
      author = an_item.children.css('h3').css('a').children.to_s.strip
      counter +=1
      songs << { order: counter, title: title, author: author }
      songs
    end).take top
  end

  def initialize
    url = "http://www.billboard.com/charts/hot-100"
    @page = Nokogiri::HTML(open(url))
  end

  attr_reader :page

end
