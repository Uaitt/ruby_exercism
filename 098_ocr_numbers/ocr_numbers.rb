class OcrNumbers
  SYMBOLS = [" _ \n| |\n|_|\n   ", "   \n  |\n  |\n   ", " _ \n _|\n|_ \n   ", " _ \n _|\n _|\n   ",
             "   \n|_|\n  |\n   ", " _ \n|_ \n _|\n   ", " _ \n|_ \n|_|\n   ", " _ \n  |\n  |\n   ",
             " _ \n|_|\n|_|\n   ", " _ \n|_|\n _|\n   "].freeze
  SYMBOL_LENGTH = 15
  COLUMN_LENGTH = 4
  ROW_LENGTH = 3

  class << self
    def convert(input)
      input = input.split("\n")
      raise(ArgumentError) if input.length % COLUMN_LENGTH != 0 || input.any? { |row| row.length % ROW_LENGTH != 0 }

      symbols = input.each_slice(COLUMN_LENGTH)
      OcrNumbers.new(symbols).convert
    end
  end

  def initialize(symbols)
    @input = ''
    @commas_num = symbols.to_a.length - 1
    symbols.each do |input|
      first_rows = input[0].scan(/.{#{ROW_LENGTH}}/)
      second_rows = input[1].scan(/.{#{ROW_LENGTH}}/)
      third_rows = input[2].scan(/.{#{ROW_LENGTH}}/)
      fourth_rows = input[3].scan(/.{#{ROW_LENGTH}}/)
      first_rows.each_with_index { |row, i| @input += "#{row}\n#{second_rows[i]}\n#{third_rows[i]}\n#{fourth_rows[i]}" }
    end
  end

  def convert
    symbols = @input.scan(/.{#{SYMBOL_LENGTH}}/m)

    raw_result = symbols.inject('') { |sum, symbol| "#{sum}#{SYMBOLS.index(symbol) || '?'}" }
    commas_num.positive? ? add_commas(raw_result) : raw_result
  end

  private

  attr_reader :input, :commas_num

  def add_commas(raw_result)
    raw_result.chars.each_slice(raw_result.length / (commas_num + 1)).to_a.map(&:join).join(',')
  end
end
