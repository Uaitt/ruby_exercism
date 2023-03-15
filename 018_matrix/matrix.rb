class Matrix
  def initialize(data)
    @data = data.split("\n").map { |row| row.strip.split(' ').map(&:to_i) }
  end

  def rows
    @data
  end

  def columns
    @data.transpose
  end
end
