require'nokogiri'

module Karajoker::Crawler::Official
  CHARTS = %w[singles end-of-year-singles audio-streaming singles-sales singles-downloads physical-singles
    vinyl-singles rock-and-metal-singles]

  CHARTS.each do |chart|
    name = chart.upcase.gsub('-', '_')
    value = "#{chart}-chart"
    const_set name, value
  end

  class Chart
    attr_reader :url

    def initialize(url)
      @url = url
      @page = Nokogiri::HTML(open(@url))
    end

    def songs(limit: 100)
      limit = 100 unless limit.present?
      items.take(limit).map{ |item| SongFactory.create(item) }
    end

    private

    def items
      @page.css('div[class=title-artist]')
    end

    def self.select(name:, at:)
      ChartBuilder.new(chart: name, at: at).build
    end
  end
end
