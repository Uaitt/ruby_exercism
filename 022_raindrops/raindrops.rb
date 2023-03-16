class Raindrops
  FACTORS = [3, 5, 7].freeze

  class << self
    def convert(number)
      raindrops = ''
      calculate_raindrops(number, raindrops)
      raindrops
    end

    private

    def calculate_raindrops(number, raindrops)
      raindrops << 'Pling' if (number % FACTORS[0]).zero?

      raindrops << 'Plang' if (number % FACTORS[1]).zero?

      raindrops << 'Plong' if (number % FACTORS[2]).zero?

      raindrops << number.to_s if !(number % FACTORS[0]).zero? &&
                                  !(number % FACTORS[1]).zero? &&
                                  !(number % FACTORS[2]).zero?
    end
  end
end
