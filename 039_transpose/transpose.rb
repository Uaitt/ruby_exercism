class Transpose
  class << self
    def transpose(input, result = '')
      return '' if input.empty?

      rows = input.split("\n")
      max_row_length = rows.each.max_by(&:length).length
      max_row_length.times { |index_column| add_transposed_column(rows, index_column, result) }
      result[0...-1]
    end

    private

    def add_transposed_column(rows, index_column, result, transposed_row = '')
      rows.each_with_index do |row, index_row|
        if !row[index_column].nil?
          transposed_row << row[index_column]
        elsif rows[(index_row + 1)..].any? { |sub_row| !sub_row[index_column].nil? }
          transposed_row << ' '
        end
      end
      result << "#{transposed_row}\n"
    end
  end
end
