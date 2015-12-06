module Crawler::Official
  class Chart
    ALL = %w(singles end-of-year-singles audio-streaming singles-sales singles-downloads physical-singles
             vinyl-singles rock-and-metal-singles)

    ALL.each { |chart| const_set chart.upcase.gsub('-', '_'), "#{chart}-chart" }

    class << self
      def select(name:, at:)
        ChartBuilder.new(chart: name, at: at).build
      end

      def years
        page = Nokogiri::HTML(open(ChartBuilder::URL))
        options = page.css('select[class=year-search]').first.css('option')
        options.shift
        options.map { |option| option.content.to_i }
      end
    end

    attr_reader :url, :date

    def initialize(url, date)
      @url = url
      @date = date
      @page = Nokogiri::HTML(open(@url))
    end

    def songs(limit: 100)
      items.take(limit).map { |item| SongFactory.create(item, @date.year) }
    end

    private

    def items
      @page.css('div[class=title-artist]')
    end
  end
end
