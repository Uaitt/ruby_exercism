class Grains
  class << self
    def square(square_number)
      raise(ArgumentError) unless square_number.between?(1, 64)

      grains_sequence[square_number - 1]
    end

    def total
      (1..64).inject(0) { |sum, square_number| sum + square(square_number) }
    end

    private

    def grains_sequence
      sequence = [1]
      63.times { sequence << sequence.last * 2 }
      sequence
    end
  end
end
