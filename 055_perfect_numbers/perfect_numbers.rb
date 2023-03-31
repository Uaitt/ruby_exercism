class PerfectNumber
  class << self
    def classify(num)
      raise(RuntimeError) if num.negative?

      factors = factors_without(num)
      return 'abundant' if factors.sum > num
      return 'deficient' if factors.sum < num

      'perfect'
    end

    private

    def factors_without(num)
      factors = []
      (1...num).each { |i| factors << i if (num % i).zero? }
      factors
    end
  end
end
