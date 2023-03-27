class Sieve
  attr_reader :range

  def initialize(limit)
    @range = (2..limit).map { |i| [i, 'prime'] }.to_h
  end

  def primes
    range.each do |key, value|
      next if value == 'composite'

      flag_multiples(key)
    end
    range.select { |_, v| v == 'prime' }.map(&:first)
  end

  private

  def flag_multiples(current_key)
    range.each do |key, _|
      range[key] = 'composite' if (key % current_key).zero? && key != current_key
    end
  end
end
