class Matrix
  def initialize(data)
    @data = data || ''
  end

  def rows
    data.split("\n").map { |row| row.split(' ').map(&:to_i) }
  end

  def columns
    rows.transpose
  end

  def saddle_points
    points = []
    rows.each_with_index do |row, row_pos|
      row.each_with_index do |value, column_pos|
        points << [row_pos, column_pos] if saddle_point?(value, row_pos, column_pos)
      end
    end
    points
  end

  private

  attr_reader :data

  def saddle_point?(value, row_pos, column_pos)
    return false if rows[row_pos].max != value

    return false if columns[column_pos].min != value

    true
  end
end
