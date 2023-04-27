class Cipher
  LETTER_A_UNICODE = 97
  LETTER_Z_UNICODE = 122
  ALPHABET_LETTERS = 26

  attr_reader :key

  def initialize(key = nil)
    @key = key || default_key
    raise(ArgumentError) if self.key.chars.any? { |letter| letter.upcase == letter } || self.key =~ /\d/ || self.key.empty?
  end

  def encode(text)
    text.chars.map.with_index do |letter, index|
      shift_factor = key[index].ord - LETTER_A_UNICODE
      offset = (letter.ord + shift_factor <= LETTER_Z_UNICODE ? 0 : ALPHABET_LETTERS)
      (letter.ord + shift_factor - offset).chr
    end.join
  end

  def decode(text)
    text.chars.map.with_index do |letter, index|
      shift_factor = key[index].ord - LETTER_A_UNICODE
      offset = (letter.ord - shift_factor >= LETTER_A_UNICODE ? 0 : ALPHABET_LETTERS)
      (letter.ord - shift_factor + offset).chr
    end.join
  end

  private

  def default_key
    (0...100).map { rand(LETTER_A_UNICODE..LETTER_Z_UNICODE).chr }.join
  end
end
