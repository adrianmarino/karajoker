module Crawler::Official::SongFactory
  def self.create(item, year)
    Song.new(year, title(item), author(item))
  end

  private

  def self.title(item)
    item.children.css('a').first.text.strip.humanize
  end

  def self.author(item)
    item.children.css('div[class=artist]').first.text.strip.humanize
  end
end
