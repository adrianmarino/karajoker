module Service
  class ServiceResponse
    attr_reader :success, :errors
    alias_method :success?, :success

    def initialize(success = true, errors = [])
      @success = success
      @errors = errors
    end
  end
end
