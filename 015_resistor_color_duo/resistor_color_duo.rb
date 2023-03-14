class ResistorColorDuo
  SCHEMA = {
    'black' => 0,
    'brown' => 1,
    'red' => 2,
    'orange' => 3,
    'yellow' => 4,
    'green' => 5,
    'blue' => 6,
    'violet' => 7,
    'grey' => 8,
    'white' => 9
  }.freeze

  class << self
    def value(colors)
      first_digit = SCHEMA[colors[0]]
      second_digit = SCHEMA[colors[1]]
      first_digit * 10 + second_digit
    end
  end
end
