module Karajoker
  module Util
    module ActiveRecordLogger
      def self.disable
        @old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
      end

      def self.enable
        ActiveRecord::Base.logger = @old_logger
      end
    end
  end
end
