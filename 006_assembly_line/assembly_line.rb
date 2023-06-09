class AssemblyLine
  CARS_PER_HOUR = 221

  def initialize(speed)
    @speed = speed || 0
  end

  def production_rate_per_hour
    @speed * CARS_PER_HOUR * success_rate
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end

  private

  def success_rate
    return 1 if @speed.between?(1, 4)

    return 0.9 if @speed.between?(5, 8)

    return 0.8 if @speed == 9

    return 0.77 if @speed == 10

    0
  end
end
