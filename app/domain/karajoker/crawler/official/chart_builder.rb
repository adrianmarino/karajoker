module Karajoker::Crawler::Official
  class ChartBuilder

    URL = 'http://www.officialcharts.com/charts'

    def initialize(chart:, at:)
      @chart = chart
      @date = at
    end

    def build
      url = URL
      if @chart.present?
        url += "/#{@chart}"
        url += "/#{@date.strftime('%Y%m%d')}" if @date.present?
      end
      Chart.new(url)
    end
  end
end
