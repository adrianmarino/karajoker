module Service
  class SongSearch < Base
    Logger = Rails.logger
    Chart = Crawler::Official::Chart
    HotChart = Crawler::Billboard::HotChart

    def call(year, limit = nil)
      songs = official_charts(year, limit).merge(hot_chart(year, limit))
      SongSearchResponse.new(songs)
    end

    private

    def hot_chart(year, limit)
      songs = HotChart.new(year).songs(limit: limit)
      logger.info "From: Hotchart, at: #{year}, Found: #{songs.size}"
      songs
    end

    def official_charts(year, limit)
      Chart::ALL.each_with_object(Set.new) do |chart, songs|
        last_day_of_each_month_of(year).each do |day|
          songs.merge(Chart.select(name: chart, at: day).songs(limit: limit))
          logger.info "From: Officialcharts, Chart: #{chart}, in: #{Date::MONTHNAMES[day.month]}, Found: #{songs.size}"
        end
      end
    end

    def last_day_of_each_month_of(year)
      start_date = Date.civil(year)
      (start_date..start_date.end_of_year).select { |date| date.day == 1 }.map(&:end_of_month)
    end
  end
end
