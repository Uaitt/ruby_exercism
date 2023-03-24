class ResistorColorTrio
  COLOR_SCHEMA = {
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

  def initialize(colors)
    @colors = colors || []
  end

  def label
    raise(ArgumentError) if colors.any? { |color| COLOR_SCHEMA[color].nil? }

    coefficient = "#{COLOR_SCHEMA[colors[0]]}#{COLOR_SCHEMA[colors[1]]}".to_i
    exponent = COLOR_SCHEMA[colors[2]]
    resistance_value = coefficient * 10**exponent
    "Resistor value: #{convert(resistance_value)}"
  end

  private

  attr_reader :colors

  def convert(resistance_value)
    return "#{resistance_value} ohms" if resistance_value < 1000

    resistance_in_kiloohms = (resistance_value / 1000).to_s.split('.').join
    "#{resistance_in_kiloohms} kiloohms"
  end
end
