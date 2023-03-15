class Matrix
  def initialize(data)
    @data = data
  end

  def rows
    string_rows = @data.split("\n")
    string_rows.map { |row| convert_to_numeric_array(row) }
  end

  def columns
    rows.transpose
  end

  private

  def convert_to_numeric_array(row)
    row.strip.split(' ').map(&:to_i)
  end
end
