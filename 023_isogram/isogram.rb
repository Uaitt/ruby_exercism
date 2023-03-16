class Isogram
  class << self
    def isogram?(input)
      input.gsub!(/[\s-]/, '')
      input.downcase!
      letters = input.split('')
      letters == letters.uniq
    end
  end
end
