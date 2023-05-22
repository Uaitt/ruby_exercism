class Diamond
  STARTING_LETTER = 'A'.freeze

  attr_accessor :result, :in_spaces, :out_spaces, :letter
  attr_reader :end_letter

  class << self
    def make_diamond(end_letter)
      Diamond.new(end_letter).make_diamond
    end
  end

  def initialize(end_letter)
    @end_letter = end_letter
    @in_spaces = -1
    @out_spaces = end_letter.ord - STARTING_LETTER.ord
    @letter = STARTING_LETTER
    @result = ''
  end

  def make_diamond
    return "A\n" if end_letter == 'A'

    self.result += initial_row
    iterations = out_spaces * 2 - 1
    iterations.times do |i|
      i <= iterations / 2 ? increment_for_first_half : increment_for_second_half
      self.result += "#{letter.rjust(out_spaces + 1)}#{spaces}#{letter.ljust(out_spaces + 1)}\n"
    end
    self.result += last_row
  end

  def initial_row
    "#{letter.rjust(out_spaces + 1).ljust(out_spaces * 2 + 1)}\n"
  end

  def last_row
    self.out_spaces += 1
    self.letter = STARTING_LETTER
    initial_row
  end

  def increment_for_first_half
    self.letter = letter.next
    self.out_spaces -= 1
    self.in_spaces += 2
  end

  def increment_for_second_half
    self.letter = (letter.ord - 1).chr
    self.out_spaces += 1
    self.in_spaces -= 2
  end

  def spaces
    (1..in_spaces).inject('') { |res, _| "#{res} " }
  end
end
