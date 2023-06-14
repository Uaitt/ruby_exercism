class FoodChain
  ANIMALS = %w[fly spider bird cat dog goat cow horse].freeze
  VERSE_START = 'I know an old lady who swallowed a'.freeze
  SECOND_SENTENCES = ['', 'It wriggled and jiggled and tickled inside her.', 'How absurd to swallow a bird!',
                      'Imagine that, to swallow a cat!', 'What a hog, to swallow a dog!',
                      'Just opened her throat and swallowed a goat!', 'I don\'t know how she swallowed a cow!'].freeze
  SWALLOWS = ['I don\'t know why she swallowed the fly. Perhaps she\'ll die',
              'She swallowed the spider to catch the fly',
              'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her',
              'She swallowed the cat to catch the bird', 'She swallowed the dog to catch the cat',
              'She swallowed the goat to catch the dog', 'She swallowed the cow to catch the goat',
              'She\'s dead, of course!'].freeze

  class << self
    def song
      initial_verse + middle_verses + final_verse
    end

    def initial_verse
      "#{VERSE_START} #{ANIMALS.first}.\n#{SWALLOWS.first}.\n\n"
    end

    def middle_verses
      ANIMALS.each_with_index.inject('') do |song, (animal, index)|
        next song if %w[fly horse].include?(animal)

        second_verse_half = SWALLOWS[0..index].inject('') { |verse, line| "#{line}.\n#{verse}" }
        song + "#{VERSE_START} #{animal}.\n#{SECOND_SENTENCES[index]}\n#{second_verse_half}\n"
      end
    end

    def final_verse
      "#{VERSE_START} #{ANIMALS.last}.\n#{SWALLOWS.last}\n"
    end
  end
end
