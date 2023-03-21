class Anagram
  def initialize(word)
    @word = word
  end

  def match(words_subset)
    words_subset.select do |candidate|
      (@word.downcase.split('').tally == candidate.downcase.split('').tally) &&
        (candidate.downcase != @word.downcase)
    end
  end
end
