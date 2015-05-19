module Karajoker::Crawler::Official::SongFactory
  def self.create(item, year = Date.current.year)
    Karajoker::Entity::Song.new(year, title(item), author(item))
  end

  private

  def self.title(item)
    item.children.css('a').first.text.strip.humanize
  end

  def self.author(item)
    item.children.css('div[class=artist]').first.text.strip.humanize
  end
end
