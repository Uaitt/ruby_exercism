class Board
  attr_reader :data, :allowed_movements

  FAIR_BOARD_MOVEMENTS = [[0, -1], [-1, 0], [0, 1], [1, 0], [-1, 1], [1, -1]].freeze
  UNFAIR_BOARD_MOVEMENTS = [[-1, 0], [0, 1], [1, 0], [1, -1], [0, -1]].freeze # removes a diagonal

  def initialize(data)
    @data = data.map { |row| row.gsub(/\s+/, '') }
    @allowed_movements = self.data.length == self.data.first.length ? FAIR_BOARD_MOVEMENTS : UNFAIR_BOARD_MOVEMENTS
  end

  def winner
    data.each_with_index do |row, row_index|
      row.chars.each_with_index do |value, column_index|
        next if value == '.' || (value == 'O' && !row_index.zero?) || (value == 'X' && !column_index.zero?)

        return value if completes_path?(value, row_index, column_index)
      end
    end
    ''
  end

  private

  def completes_path?(value, row_index, column_index, last_movement = [0, 0])
    return true if arrived_to_edge?(value, row_index, column_index)

    direction = allowed_movements.find { |movement| can_move?(movement, value, row_index, column_index, last_movement) }
    return false unless direction

    new_position = row_index + direction.first, column_index + direction.last
    completes_path?(value, *new_position, direction.map(&:-@))
  end

  def arrived_to_edge?(value, row_index, column_index)
    (value == 'X' && column_index == data.first.length - 1) || (value == 'O' && row_index == data.length - 1)
  end

  def can_move?(movement, value, row_index, column_index, last_movement)
    new_row = movement.first + row_index
    new_column = movement.last + column_index
    (0...data.length).include?(new_row) && (0...data.first.length).include?(new_column) &&
      movement != last_movement && data[new_row][new_column] == value
  end
end
