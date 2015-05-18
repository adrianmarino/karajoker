require'nokogiri'

module Karajoker::Crawler::OfficialChart
  class RockAndMetalSinglesChart
    def songs(top:)
      @items.map{ |item| SongFactory.create(item) }.take(top)
    end

    private

    def initialize
      @items = Nokogiri::HTML(open(URL)).css('div[class=title-artist]')
    end

    URL = 'http://www.officialcharts.com/charts/rock-and-metal-singles-chart'
  end
end
