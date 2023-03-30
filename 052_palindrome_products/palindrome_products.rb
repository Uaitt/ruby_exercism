require 'prime'

class Palindromes
  Palindrome = Struct.new(:value, :factors)

  def initialize(**range)
    range[:min_factor] = 1 unless range[:min_factor]

    @range = (range[:min_factor]..range[:max_factor])
    @data = []
  end

  def generate
    products.each do |product|
      if palindrome?(product)
        factors = factors_in_range(product)
        data << Palindrome.new(product, factors)
      end
    end
    data.sort_by!(&:value)
  end

  def largest
    data.last
  end

  def smallest
    data.first
  end

  attr_reader :range, :data

  def products
    @products ||= calculate_products
  end

  def calculate_products
    combinations = range.to_a.combination(2)
    products = combinations.map { |combination| combination.first * combination.last }
    range.each { |value| products << value**2 }
    products.uniq
  end

  def palindrome?(product)
    product.to_s.reverse == product.to_s
  end

  def factors_in_range(num)
    return [1, 1] if num == 1

    prime_divisors = num.prime_division
    factors = cartesian_product(prime_divisors, num)
    factors.select { |f| range.include?(f.first) && range.include?(f.last) }
  end

  def cartesian_product(prime_divisors, num)
    factors = prime_divisors.map { |value, exp| (0..exp).map { |i| value**i } }
    factors = factors.first.product(*factors[1..]).map { |f| f.reduce(:*) }.map { |m| [m, num / m] }
    factors.map(&:sort).uniq
  end
end
