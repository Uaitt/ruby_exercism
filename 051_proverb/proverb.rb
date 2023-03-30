class Proverb
  def initialize(*input, **qualifier)
    @input = input
    @qualifier = qualifier
  end

  def to_s
    proverb = ''
    input.each_with_index do |current_word, index|
      next if current_word == input.last

      next_word = input[index + 1]
      proverb << "For want of a #{current_word} the #{next_word} was lost.\n"
    end
    proverb << "And all for the want of a #{final_cause}."
  end

  private

  attr_reader :input, :qualifier

  def final_cause
    return input.first if qualifier.empty?

    "#{qualifier.values.first} #{input.first}"
  end
end
