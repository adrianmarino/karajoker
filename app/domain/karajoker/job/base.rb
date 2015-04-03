
module Karajoker::Job::Base
  include Util::ActiveRecordLogger
  Logger = Rails.logger

  def start
    disable_active_record_logger
    run
    enable_active_record_logger
    true
  ensure
    false
  end

end
