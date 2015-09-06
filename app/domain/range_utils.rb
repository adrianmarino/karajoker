module RangeUtils
  def self.from(value)
    return unless value
    range = value.split('..').map(&:to_i)
    range << range.first if range.size == 1
    Range.new(*range)
  end
end
