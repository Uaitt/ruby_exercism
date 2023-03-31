class Prime
  class << self
    def nth(wanted_index)
      raise(ArgumentError) if wanted_index < 1

      value = 2
      current_index = 1
      loop do
        return value if wanted_index == current_index

        current_index += 1 if prime?(value += 1)
      end
    end

    def prime?(num)
      (2..Math.sqrt(num)).none? { |i| (num % i).zero? }
    end
  end
end
