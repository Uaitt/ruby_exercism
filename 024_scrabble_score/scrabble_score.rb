class Scrabble
  LETTER_VALUES = {
    %w[a e i o u l n r s t] => 1,
    %w[d g] => 2,
    %w[b c m p] => 3,
    %w[f h v w y] => 4,
    %w[k] => 5,
    %w[j x] => 8,
    %w[q z] => 10
  }.freeze

  def initialize(word)
    @word = word || ''
  end

  def score
    @word.downcase.split('').inject(0) do |score, letter|
      key = LETTER_VALUES.keys.find { |k| k.include?(letter) }
      score + LETTER_VALUES[key]
    end
  end
end
