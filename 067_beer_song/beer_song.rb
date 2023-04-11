class BeerSong
  class << self
    def recite(start_verse, verse_numbers)
      (0...verse_numbers).inject('') { |song, i| song + verse(start_verse - i) }[0...-1]
    end

    def verse(verse_num)
      case verse_num
      when 0
        "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n\n"
      when 1
        "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n\n"
      when 2
        "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n\n"
      else
        "#{verse_num} bottles of beer on the wall, #{verse_num} bottles of beer.\nTake one down and pass it around, #{verse_num - 1} bottles of beer on the wall.\n\n"
      end
    end
  end
end
