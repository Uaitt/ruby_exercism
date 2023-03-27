class CollatzConjecture
  class << self
    def steps(n, steps = 0)
      raise(ArgumentError) if n <= 0

      return steps if n == 1

      if n.even?
        steps(n / 2, steps + 1)
      else
        steps(3 * n + 1, steps + 1)
      end
    end
  end
end
