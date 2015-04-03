module Karajoker::Job::Base
  Logger = Rails.logger

  def start
    run
    true
  ensure
    false
  end
end
