module Karajoker::Service
  class Base
    include Sidekiq::Worker
    include Karajoker::Logger
  end
end
