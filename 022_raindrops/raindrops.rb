class Raindrops
  FACTORS = [3, 5, 7].freeze

  class << self
    def convert(number, raindrops = '')
      raindrops << 'Pling' if (number % FACTORS[0]).zero?
      raindrops << 'Plang' if (number % FACTORS[1]).zero?
      raindrops << 'Plong' if (number % FACTORS[2]).zero?
      raindrops.empty? ? number.to_s : raindrops
    end
  end
end
