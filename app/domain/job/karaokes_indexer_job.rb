module Job
  class KaraokesIndexerJob
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(limit, years)
      years = resolve(years)
      log_args(limit, years)
      years.each { |year| KaraokeIndexerByYearWithLimitJob.perform_async(limit, year) }
    end

    private

    def log_args(limit, years)
      logger.info "Arguments: Get #{limit} song/s per chart between #{years}"
    end

    def resolve(years)
      RangeUtils.from(years) || Crawler::Official::Chart.years
    end
  end
end
