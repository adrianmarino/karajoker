module Karajoker::Util
  module ActiveRecordLogger
    def disable_active_record_logger
      @old_logger = ActiveRecord::Base.logger
      ActiveRecord::Base.logger = nil
    end

    def enable_active_record_logger
      ActiveRecord::Base.logger = @old_logger
    end
  end
end
