class Microwave
  attr_reader :minutes, :seconds

  def initialize(value)
    @minutes = value / 100
    @seconds = value - (minutes * 100)
    @minutes += seconds / 60
    @seconds -= 60 if seconds >= 60
  end

  def timer
    formatted_minutes = @minutes.to_s.rjust(2, '0')
    formatted_seconds = @seconds.to_s.rjust(2, '0')
    "#{formatted_minutes}:#{formatted_seconds}"
  end
end
