class Class
  def cache_instance_method(name:, expires: 10.minutes)
    initialize_storage
    wrap_instance_method(pattern: /^#{name}$/, &new_wrapper(name, expires))
  end

  def cache_method(name:, expires: 10.minutes)
    initialize_storage
    wrap_method(pattern: /^#{name}$/, &new_wrapper(name, expires))
  end

  private

  def initialize_storage
    LockAndCache.storage = Redis.new unless LockAndCache.storage
  end

  def new_wrapper(method_name, expires)
    lambda do |method, *args, &block|
      LockAndCache.lock_and_cache(method_name, args, expires: expires) do
        Rails.logger.debug("Save response of #{method_name}(#{args}) message!")
        method.call(*args, &block)
      end
    end
  end
end

unless Rails.env == 'test'
  Service::SongSearch.cache_instance_method(name: :select_official_chart_songs, expires: 1.week)
  Service::SongSearch.cache_instance_method(name: :hot_chart_songs, expires: 1.week)
  Service::KaraokeCreate.cache_instance_method(name: :search_karaoke, expires: 1.week)
end
