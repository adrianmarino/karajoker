module Service
  class Base
    include Sidekiq::Worker
    include AppLogger
  end
end
