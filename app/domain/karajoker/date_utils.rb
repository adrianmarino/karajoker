module Karajoker::DateUtils
  def self.current_year
    Date.today.strftime("%Y")
  end
end
