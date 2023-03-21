class Triangle
  def initialize(sides)
    @sides = sides
  end

  def equilateral?
    triangle? && @sides.uniq.size == 1
  end

  def isosceles?
    triangle? && (@sides.uniq.size == 2 || @sides.uniq.size == 1)
  end

  def scalene?
    triangle? && @sides.uniq.size == 3
  end

  private

  def triangle?
    a = @sides[0]
    b = @sides[1]
    c = @sides[2]
    (a + b) > c && (a + c) > b && (b + c) > a
  end
end
