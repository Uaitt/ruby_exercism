class Darts
  attr_reader :x_cord, :y_cord

  INNER_CIRCLE = (0..1).freeze
  MIDDLE_CIRCLE = (1..5).freeze
  OUTER_CIRCLE = (5..10).freeze

  def initialize(x_cord, y_cord)
    @x_cord = x_cord
    @y_cord = y_cord
  end

  def score
    distance = Math.sqrt(x_cord**2 + y_cord**2)
    case distance
    in INNER_CIRCLE then 10
    in MIDDLE_CIRCLE then 5
    in OUTER_CIRCLE then 1
    else 0
    end
  end
end
