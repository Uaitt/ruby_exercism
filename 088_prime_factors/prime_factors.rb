class PrimeFactors
  class << self
    def of(num)
      factors = []
      div = 2
      until num == 1
        if (num % div).zero?
          num /= div
          factors << div
        else
          div += 1
        end
      end
      factors
    end
  end
end
