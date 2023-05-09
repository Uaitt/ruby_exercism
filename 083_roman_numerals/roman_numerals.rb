class Integer
  ROMAN_NUMBERS = { 1 => 'I', 4 => 'IV', 5 => 'V', 9 => 'IX', 10 => 'X', 40 => 'XL', 50 => 'L',
                    90 => 'XC', 100 => 'C', 400 => 'CD', 500 => 'D', 900 => 'CM', 1000 => 'M' }.freeze

  def to_roman
    current_value = self
    roman_solution = ''
    until current_value.zero?
      decimal_value = ROMAN_NUMBERS.keys.reverse.find { |item| item <= current_value }
      roman_solution << ROMAN_NUMBERS[decimal_value]
      current_value -= decimal_value
    end
    roman_solution
  end
end
