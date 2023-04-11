class Board
  VALID_CHARS = ['+', '-', '|', ' ', '*'].freeze

  class << self
    def transform(input)
      new(input).transform
    end
  end

  def initialize(input)
    @input = input
    @count = 0
  end

  def transform
    input.each_with_index do |line, row_index|
      raise(ArgumentError) if invalid_line?(line)

      line.chars.each_with_index do |char, column_index|
        raise(ArgumentError) if invalid_char?(char, row_index)

        count_mines(row_index, column_index) if char == ' '
      end
    end
    input
  end

  private

  attr_accessor :input, :count

  def count_mines(row_index, column_index)
    count_vertically(row_index, column_index)
    count_horizontally(row_index, column_index)
    count_diagonally(row_index, column_index)
    input[row_index][column_index] = count.to_s unless count.zero?
    self.count = 0
  end

  def count_vertically(row_index, column_index)
    self.count += 1 if input[row_index + 1][column_index] == '*'

    self.count += 1 if input[row_index - 1][column_index] == '*' && row_index.nonzero?
  end

  def count_horizontally(row_index, column_index)
    self.count += 1 if input[row_index][column_index + 1] == '*'

    self.count += 1 if input[row_index][column_index - 1] == '*' && column_index.nonzero?
  end

  def count_diagonally(row_index, column_index)
    self.count += 1 if input[row_index + 1][column_index + 1] == '*'

    self.count += 1 if input[row_index - 1][column_index + 1] == '*' && row_index.nonzero?

    self.count += 1 if input[row_index + 1][column_index - 1] == '*' && column_index.nonzero?

    self.count += 1 if input[row_index - 1][column_index - 1] == '*' && row_index.nonzero? && column_index.nonzero?
  end

  def invalid_line?(line)
    line.length != input.first.length
  end

  def invalid_char?(char, row_index)
    !VALID_CHARS.include?(char) || invalid_border?(char, row_index)
  end

  def invalid_border?(char, row_index)
    (row_index.zero? && (char != '+' && char != '-')) ||
      (row_index == input.length - 1 && (char != '+' && char != '-'))
  end
end
