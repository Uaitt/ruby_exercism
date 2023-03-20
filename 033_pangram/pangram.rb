class Pangram
  LETTERS = ('a'..'z').freeze

  class << self
    def pangram?(sentence)
      letter_count = sentence.downcase.split('').tally
      LETTERS.all? { |letter| letter_count.key?(letter) }
    end
  end
end
