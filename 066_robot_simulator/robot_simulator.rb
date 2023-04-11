class Robot
  VALID_DIRECTIONS = %i[north south east west].freeze

  attr_accessor :direction, :coordinates

  def orient(direction)
    raise ArgumentError unless VALID_DIRECTIONS.include?(direction)

    @direction = direction
  end

  def turn_right
    case direction
    when :north then self.direction = :east
    when :east then self.direction = :south
    when :south then self.direction = :west
    when :west then self.direction = :north
    end
  end

  def turn_left
    case direction
    when :north then self.direction = :west
    when :west then self.direction = :south
    when :south then self.direction = :east
    when :east then self.direction = :north
    end
  end

  def at(*coordinates)
    @coordinates = coordinates
  end

  def advance
    case direction
    when :north then coordinates[1] += 1
    when :east then coordinates[0] += 1
    when :south then coordinates[1] -= 1
    when :west then coordinates[0] -= 1
    end
  end

  alias bearing direction
end

class Simulator
  MOVEMENT_MAPPING = { 'L' => :turn_left, 'R' => :turn_right, 'A' => :advance }.freeze

  def instructions(instructions)
    instructions.chars.map { |instruction| MOVEMENT_MAPPING[instruction] }
  end

  def place(robot, **opts)
    robot.at(opts[:x], opts[:y])
    robot.orient(opts[:direction])
  end

  def evaluate(robot, instructions)
    self.instructions(instructions).each { |instruction| robot.send(instruction) }
  end
end
