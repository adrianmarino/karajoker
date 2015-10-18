module Service
  class SongSearch
    include AppLogger
    Chart = Crawler::Official::Chart

    def call(year, limit = nil)
      songs = official_charts(year, limit).merge(hot_chart(year, limit))
      SongSearchResponse.new(songs)
    end

    private

    def hot_chart(year, limit)
      songs = Crawler::Billboard::HotChart.new(year).songs(limit: limit)
      logger.info "From: Hotchart, at: #{year}, Found: #{songs.size}"
      songs
    end

    def official_charts(year, limit)
      Chart::ALL.each_with_object(Set.new) do |chart, songs|
        last_day_of_each_month_of(year).each do |day|
          songs.merge(Chart.select(name: chart, at: day).songs(limit: limit))
          month_name = Date::MONTHNAMES[day.month]
          logger.info "From: Officialcharts, Chart: #{chart}, in: #{month_name}, Found: #{songs.size}"
        end
      end
    end

    def last_day_of_each_month_of(year)
      start_date = Date.civil(year)
      (start_date..start_date.end_of_year).select { |date| date.day == 1 }.map(&:end_of_month)
    end
  end
end
