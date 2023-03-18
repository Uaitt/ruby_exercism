class Phrase
  def initialize(phrase)
    @phrase = phrase || ''
  end

  def word_count
    @phrase.downcase.scan(/\b[\w']+\b/).tally
  end
end
