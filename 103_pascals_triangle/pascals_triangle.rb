class Triangle
  INITIAL_LINE = [1].freeze

  attr_reader :rows, :total_rows

  def initialize(total_rows)
    @total_rows = total_rows
    @rows = []
    process
  end

  private

  def process
    total_rows.times do |row_num|
      next rows << INITIAL_LINE if row_num.zero?

      rows << []
      numbers_in_row = rows[-2].length + 1
      numbers_in_row.times do |num_index|
        if num_index.zero? || num_index == rows[-2].length
          rows.last << 1
        else
          left, right = rows[-2][num_index - 1..num_index]
          rows.last << (left + right)
        end
      end
    end
  end
end
