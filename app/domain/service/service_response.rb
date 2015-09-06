module Service
  class ServiceResponse
    attr_reader :errors

    def success?
      @success
    end

    def initialize(success = true, errors = [])
      @success = success
      @errors = errors
    end
  end
end
