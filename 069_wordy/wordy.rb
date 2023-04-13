class WordProblem
  OPERATIONS = { 'plus' => '+', 'minus' => '-', 'multiplied' => '*', 'divided' => '/' }.freeze

  def initialize(sentence)
    @sentence = sentence.chop.split(' ')
  end

  def answer
    clear_values
    sentence.each { |word| manage_word(word) }
    accumulator || raise(ArgumentError)
  end

  private

  attr_accessor :num1, :num2, :operation, :accumulator
  attr_reader :sentence

  def manage_word(word)
    if Integer(word, exception: false)
      num1 ? self.num2 = word.to_i : self.num1 = word.to_i
    end

    self.operation = OPERATIONS[word] if OPERATIONS.keys.include?(word)

    return if num1.nil? || num2.nil?

    accumulate
  end

  def clear_values
    self.num1 = self.num2 = self.accumulator = nil
  end

  def accumulate
    self.accumulator = num1.send(operation, num2)
    self.num1 = accumulator
    self.num2 = nil
  end
end
