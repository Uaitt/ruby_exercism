class PigLatin
  VOWELS = %w[a e i o u].freeze
  PIG_LATIN_SOUND = 'ay'.freeze
  SPECIAL_SOUNDS = %w[qu y].freeze

  class << self
    def translate(input)
      input.split.inject('') do |result, word|
        if starts_with_vowel_sound?(word)
          result + "#{word}#{PIG_LATIN_SOUND} "
        else
          consonant_sound = word.include?(SPECIAL_SOUNDS.first) ? word.slice(0..word.index('u')) : get_consonant_sound(word)
          result + "#{word.sub(consonant_sound, '')}#{consonant_sound}#{PIG_LATIN_SOUND} "
        end
      end.chop
    end

    private

    def starts_with_vowel_sound?(input)
      VOWELS.include?(input[0]) || input[0..1] == 'yt' || input[0..1] == 'xr'
    end

    def get_consonant_sound(input)
      input.chars.inject do |result, char|
        return result if VOWELS.include?(char) || (char == SPECIAL_SOUNDS.last && !result.empty?)

        result + char
      end
    end
  end
end
