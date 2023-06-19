class Queens
  VALID_POSITIONS = (0..7).freeze

  def initialize(white: [], black: [])
    raise(ArgumentError) if invalid_pos?(white) || invalid_pos?(black)

    @white_pos = white
    @black_pos = black
  end

  def attack?
    horizontal? || vertical? || diagonal?
  end

  private

  attr_reader :white_pos, :black_pos

  def invalid_pos?(position)
    position.any? { |coordinate| !VALID_POSITIONS.include?(coordinate) }
  end

  def horizontal?
    white_pos.first == black_pos.first
  end

  def vertical?
    white_pos.last == black_pos.last
  end

  def diagonal?
    movement = white_pos.zip(black_pos).map { |finish, start| finish - start }
    movement.first.abs == movement.last.abs
  end
end
