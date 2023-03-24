class ETL
  class << self
    def transform(old_scrabble)
      new_scrabble = {}
      old_scrabble.each do |points, letters|
        letters.each { |letter| new_scrabble[letter.downcase] = points }
      end
      new_scrabble
    end
  end
end
