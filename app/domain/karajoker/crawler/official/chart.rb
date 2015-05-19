require'nokogiri'

module Karajoker::Crawler::Official
  CHARTS = %w[singles end-of-year-singles audio-streaming singles-sales singles-downloads physical-singles vinyl-singles rock_and_metal_singles]
  CHARTS.each { |chart| const_set chart.upcase, "#{chart.gsub('_', '-')}-chart" }

  class Chart
    attr_reader :url

    def songs(limit:)
      items.map{ |item| SongFactory.create(item) }.take(limit)
    end

    private

    def items
      @page.css('div[class=title-artist]')
    end

    def initialize(url)
      @url = url
      @page = Nokogiri::HTML(open(@url))
    end

    def self.select(name:, at:)
      ChartBuilder.new(chart: name, at: at).build
    end
  end
end
