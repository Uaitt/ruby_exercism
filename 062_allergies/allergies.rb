class Allergies
  SCORES = { 'eggs' => 1, 'peanuts' => 2, 'shellfish' => 4, 'strawberries' => 8,
             'tomatoes' => 16, 'chocolate' => 32, 'pollen' => 64, 'cats' => 128 }.freeze

  def initialize(score)
    @score = score
    reduce_score
  end

  def allergic_to?(item)
    list.include?(item)
  end

  def list
    possible_values = SCORES.values.select { |val| val <= score }

    possible_values.reverse_each.map do |possible_value|
      if possible_value <= score
        self.score -= possible_value
        SCORES.key(possible_value)
      end
    end.compact.reverse
  end

  private

  attr_accessor :score

  def reduce_score
    self.score -= 256 while score > SCORES.values.sum
  end
end


