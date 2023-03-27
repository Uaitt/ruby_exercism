class PythagoreanTriplet
  class << self
    def triplets_with_sum(sum, triplets = [])
      (1..sum / 3).each do |a|
        b = (sum**2 - 2 * sum * a) / (2 * sum - 2 * a)
        c = sum - a - b

        triplets << [a, b, c] if pythagorean_triplet?(a, b, c)
      end
      triplets.map(&:sort).uniq
    end

    def pythagorean_triplet?(a, b, c)
      a**2 + b**2 == c**2
    end
  end
end
