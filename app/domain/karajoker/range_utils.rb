module Karajoker::RangeUtils
  def self.from(value)
    Range.new(*value.split('..').map(&:to_i))
  end
end
