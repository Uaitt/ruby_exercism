class Alphametics
  class << self
    VALID_RESULTS = (0..9).to_a.freeze

    def solve(puzzle)
      unique_letters = split_to_letters(puzzle)
      addends = split_to_addends(puzzle)
      VALID_RESULTS.permutation(unique_letters.length) do |permutation|
        return build_matching(permutation, unique_letters) if permutation_matches?(permutation, addends, unique_letters)
      end
      {}
    end

    private

    def split_to_letters(puzzle)
      puzzle.split(/[\s+==]/).join.split('').uniq
    end

    def split_to_addends(puzzle)
      puzzle.split(/\s/).select.with_index { _2.even? }
    end

    def permutation_matches?(permutation, addends, unique_letters)
      letters_value_matching = build_matching(permutation, unique_letters)
      return false if sum_carries?(addends) && letters_value_matching[addends.last[0]] != 1

      addends = convert_to_values(addends, letters_value_matching)
      return false if addends.any? { |addend| addend.first.zero? }

      addends = addends.map { |addend| addend.join.to_i }
      addends.slice!(-1) == addends.sum
    end

    def build_matching(permutation, unique_letters)
      letters_value_matching = {}
      permutation.each.with_index { |val, ind| letters_value_matching[unique_letters[ind]] = val }
      letters_value_matching
    end

    def convert_to_values(addends, letters_value_matching)
      addends.map do |addend|
        letters = addend.split('')
        letters.map { |letter| letters_value_matching[letter] }
      end
    end

    def sum_carries?(addends)
      addends.all? { |addend| addend.length <= addends.last.length }
    end
  end
end
