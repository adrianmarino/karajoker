module Service
  class Base
    include Sidekiq::Worker
  end
end
