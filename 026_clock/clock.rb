class Clock
  def initialize(hour: 0, minute: 0)
    @total_minutes = hour * 60 + minute
  end

  def to_s
    formatted_hours = hours.to_s.rjust(2, '0')
    formatted_minutes = minutes.to_s.rjust(2, '0')
    "#{formatted_hours}:#{formatted_minutes}"
  end

  def +(other)
    @total_minutes += other.hours * 60 + other.minutes
    to_s
  end

  def -(other)
    @total_minutes -= other.hours * 60 + other.minutes
    to_s
  end

  def ==(other)
    hours == other.hours && minutes == other.minutes
  end

  def hours
    @hours ||= begin
      raw_hours = @total_minutes / 60
      if raw_hours >= 24 || raw_hours <= -24
        raw_hours % 24
      elsif raw_hours.negative?
        24 + raw_hours
      else
        raw_hours
      end
    end
  end

  def minutes
    @minutes ||= @total_minutes % 60
  end
end
