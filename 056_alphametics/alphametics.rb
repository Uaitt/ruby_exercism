# Shamelessly stolen from AlexB52's solution
# https://github.com/AlexB52/exercism-ruby/blob/main/alphametics/alphametics.rb

class Alphametics
  attr_reader :rows, :leading_letter

  class << self
    def solve(puzzle)
      new(puzzle).solve
    end
  end

  def initialize(puzzle)
    @rows = puzzle.scan(/[A-Z]+/)
    @leading_letter = rows.max_by(&:length)[0]
  end

  def solve
    (1..9).each do |i|
      ((0..9).to_a - [i]).permutation(linear_equation.length - 1) do |permutation|
        next unless permutation.unshift(i)
                               .zip(equation_coefficients)
                               .sum { |x, y| x * y }
                               .zero?

        return equation_letters.zip(permutation).to_h
      end
    end
    {}
  end

  private

  def equation_coefficients
    @equation_coefficients ||= linear_equation.map(&:last)
  end

  def equation_letters
    @equation_letters ||= linear_equation.map(&:first)
  end

  # Transform the string equation into a linear equation with coefficients.
  def linear_equation
    @linear_equation ||= begin
      *addends, sum = rows
      result = Hash.new { |h, k| h[k] = 0 }
      addends.each do |row|
        row.reverse.chars.each_with_index { |letter, power| result[letter] += 10**power }
      end
      sum.reverse.chars.each_with_index { |letter, power| result[letter] -= 10**power }
      result.sort_by { |k, _| leading_letter == k ? 0 : 1 }
    end
  end
end
