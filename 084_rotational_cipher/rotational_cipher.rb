class RotationalCipher
  ALPHABET_LENGTH = 26

  class << self
    def rotate(input, key)
      input.chars.inject('') do |sol, letter|
        sol + if letter.match?(/[^a-zA-Z]/)
                letter
              elsif overflow?(letter, key)
                (letter.ord + key).chr
              else
                (letter.ord + key - ALPHABET_LENGTH).chr
              end
      end
    end

    private

    def overflow?(letter, key)
      letter.upcase != letter && letter.ord + key <= 'z'.ord || letter.ord + key <= 'Z'.ord
    end
  end
end
