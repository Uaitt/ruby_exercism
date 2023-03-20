class Gigasecond
  ONE_GIGA_SECOND = 1_000_000_000

  class << self
    def from (time)
      time + ONE_GIGA_SECOND
    end
  end
end
