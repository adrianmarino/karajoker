module Service
  class SongSearch
    include AppLogger

    def call(year, limit = nil)
      songs = official_chart_songs(year, limit).merge(hot_chart_songs(year, limit))
      songs = filter_repeated(songs)
      SongSearchResponse.new(songs)
    end

    protected

    def select_official_chart_songs(name:, at:, limit:)
      Crawler::Official::Chart.select(name: name, at: at).songs(limit: limit)
    end

    def hot_chart_songs(year, limit)
      songs = Crawler::Billboard::HotChart.new(year).songs(limit: limit)
      logger.info "From: Hotchart, at: #{year}, Found: #{songs.size}"
      songs
    end

    private

    def filter_repeated(songs)
      result = songs.to_a.uniq(&:title)
      logger.info "<< Filter #{songs.size - result.size} repeated songs of #{songs.size} >>"
      result
    end

    def official_chart_songs(year, limit)
      Crawler::Official::Chart::ALL.each_with_object(Set.new) do |chart, songs|
        last_day_of_each_month_of(year).each do |day|
          songs.merge(select_official_chart_songs(name: chart, at: day, limit: limit))
          logger.info("From: Officialcharts, Chart: #{chart}, "\
                      "in: #{Date::MONTHNAMES[day.month]}, "\
                      "Found: #{songs.size}")
        end
      end
    end

    def last_day_of_each_month_of(year)
      start_date = Date.civil(year)
      (start_date..start_date.end_of_year).select { |date| date.day == 1 }.map(&:end_of_month)
    end
  end
end
