class SumOfMultiples
  def initialize(*factors)
    @factors = factors
  end

  def to(limit, multiples = [])
    @factors.each { |factor| multiples += multiples_for(factor, limit) }
    multiples.uniq.sum
  end

  def multiples_for(factor, limit)
    multiples = []
    i = 1
    while factor * i < limit && !factor.zero?
      multiples << factor * i
      i += 1
    end
    multiples
  end
end
