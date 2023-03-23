# PLEASE NOTE THAT SOME TESTS ON THIS EXERCISES ARE PROBABLY WRONG
# in some of them, the resulting matrix has columns of different lengths, which is impossible for a transposed matrix!

class Transpose
  class << self
    def transpose(input)
      raw_rows = input.split("\n")
      pad(raw_rows)
      rows = raw_rows.map(&:chars)
      columns = rows.transpose
      string = []
      columns.each { |column| string << "#{column.join}\n" }
      string.join[0...-1]
    end

    def pad(rows)
      row_length = find_max_length(rows)
      rows.each { |row| row << '' while row.length != row_length }
    end

    def find_max_length(rows)
      max = 0
      rows.each { |row| max = row.length if row.length > max }
      max
    end
  end
end
