class TwelveDays
  class << self
    def song(full_song = '')
      verse_number = 1
      while verse_number <= 12
        full_song += Verse.new(verse_number).data
        verse_number += 1
      end
      full_song
    end
  end
end

class Verse
  CHRISTMAS_GIFTS = {
    1 => "a Partridge in a Pear Tree.\n\n",
    2 => "two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    3 => "three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    4 => "four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    5 => "five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    6 => "six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    7 => "seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    8 => "eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    9 => "nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    10 => "ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    11 => "eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n\n",
    12 => "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
  }.freeze

  attr_reader :data

  def initialize(verse_number)
    @data = "#{first_part(verse_number)}: #{second_part(verse_number)}"
  end

  def first_part(verse_number)
    order = NumberConverter.new(verse_number).ordinalize
    "On the #{order} day of Christmas my true love gave to me"
  end

  def second_part(verse_number)
    CHRISTMAS_GIFTS[verse_number]
  end
end

class NumberConverter
  ORDINAL_NUMBERS = {
    1 => 'first',
    2 => 'second',
    3 => 'third',
    4 => 'fourth',
    5 => 'fifth',
    6 => 'sixth',
    7 => 'seventh',
    8 => 'eighth',
    9 => 'ninth',
    10 => 'tenth',
    11 => 'eleventh',
    12 => 'twelfth'
  }.freeze

  def initialize(number)
    @number = number
  end

  def ordinalize
    ORDINAL_NUMBERS[@number]
  end
end
