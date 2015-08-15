module Karajoker::Service
  class SongSearch < Base
    Logger = Rails.logger
    Chart = Karajoker::Crawler::Official::Chart
    HotChart = Karajoker::Crawler::Billboard::HotChart

    def call(year, limit = nil)
      songs = official_charts(year, limit).merge(hot_chart(year, limit))
      SongSearchResponse.new(songs)
    end

    private

    def hot_chart(year, limit)
      logger.info "(origin: hotchart): Search songs at: #{year}"
      HotChart.new(year).songs(limit: limit)
    end

    def official_charts(year, limit)
      Chart::ALL.each_with_object(Set.new) do |chart, songs|
        last_day_of_each_month_of(year).each do |day|
          songs.merge(Chart.select(name: chart, at: day).songs(limit: limit))
          logger.info "(origin: officialcharts, chart: #{chart}): Search songs(#{songs.size}) at: #{day}"
        end
      end
    end

    def last_day_of_each_month_of(year)
      start_date = Date.civil(year)
      (start_date..start_date.end_of_year).select { |date| date.day == 1 }.map(&:end_of_month)
    end
  end
end
