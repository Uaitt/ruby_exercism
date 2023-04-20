class Atbash
  PLAIN_ALPHABET = ('a'..'z').to_a.freeze
  CIPHER_ALPHABET = ('a'..'z').to_a.reverse.freeze

  class << self
    def encode(input, result = [])
      input.downcase.gsub(/[.,\s+]/, '').chars do |letter|
        result << (Integer(letter, exception: false) ? letter : CIPHER_ALPHABET[PLAIN_ALPHABET.index(letter)])
        result << ' ' if (result.join.gsub(/\s+/, '').length % 5).zero?
      end
      result.join.strip
    end

    def decode(input)
      input.downcase.gsub(/\s+/, '').chars.map do |letter|
        Integer(letter, exception: false) ? letter : PLAIN_ALPHABET[CIPHER_ALPHABET.index(letter)]
      end.join
    end
  end
end
