module Karajoker::Service
  class KaraokeCreateResponse < ServiceResponse
    attr_reader :count

    def initialize(count, success = true, errors = [])
      super(success, errors)
      @count = count
    end
  end
end
