class Crypto
  def initialize(input)
    @input = input.downcase.gsub(/[^a-z0-9]/, '')
  end

  def ciphertext
    return '' if input.empty?

    input << ' ' until input.length == factors[0] * factors[1]
    rows = input.scan(/.{#{factors[0]}}/)

    result = ''
    rows.first.length.times do |column_index|
      rows.each { |row| result << row[column_index] }
      result << ' '
    end
    result[0...-1]
  end

  private

  attr_reader :input

  def factors
    r = c = 1
    loop do
      return [c, r] if c * r >= input.length

      c += 1
      return [c, r] if c * r >= input.length

      r += 1
    end
  end
end
