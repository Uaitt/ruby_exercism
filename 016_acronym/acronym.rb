class Acronym
  class << self
    def abbreviate(phrase)
      words = phrase.split(/[\s-]/)
      words.map(&:chr).join.upcase
    end
  end
end
