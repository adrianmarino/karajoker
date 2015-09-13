module LoggerConfig
  def self.setup(logger)
    logger.level = Logger::INFO
    logger.formatter = proc do |severity, datetime, progname, message|
      date_format = datetime.strftime('%Y-%m-%d %H:%M:%S:%L')
      "#{date_format} #{severity} #{progname}: #{message}\n"
    end
    disable_active_record_logs
    logger
  end

  def self.disable_active_record_logs
    @old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil
  end

  def self.enable_active_record_logs
    ActiveRecord::Base.logger = @old_logger
  end
end
