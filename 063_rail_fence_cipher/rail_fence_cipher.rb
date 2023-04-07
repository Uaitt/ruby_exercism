class RailFenceCipher
  attr_reader :total_rails
  attr_accessor :sentence, :rails_num, :rails_column_num, :rails, :going_down

  class << self
    def encode(sentence, total_rails)
      new(sentence, total_rails).encode
    end

    def decode(sentence, total_rails)
      new(sentence, total_rails).decode
    end
  end

  def initialize(sentence, total_rails)
    @sentence = sentence
    @total_rails = total_rails
    @rails_num = @rails_column_num = 0
    @rails = Array.new(total_rails) { Array.new(sentence.gsub(/\s/, '').length, '') }
  end

  def encode
    return sentence if total_rails == 1 || sentence.length <= total_rails

    sentence.gsub!(/\s/, '')
    sentence.chars.each { |letter| manage_letter(letter) }
    rails.flatten.join
  end

  def decode
    return sentence if total_rails == 1 || sentence.length <= total_rails

    construct_fake_rails
    place_in_rails
    read_rails
  end

  private

  def manage_letter(letter)
    self.going_down = true if rails_num.zero?
    self.going_down = false if rails_num == total_rails - 1
    rails[rails_num][rails_column_num] = letter
    move_index
  end

  def move_index
    rails_num.zero? || going_down ? self.rails_num += 1 : self.rails_num -= 1
    self.rails_column_num += 1
  end

  def construct_fake_rails
    (' ' * sentence.length).chars.each { |letter| manage_letter(letter) } # ' ' cannot be present in our rails by definition
    self.rails_num = self.rails_column_num = 0
  end

  def place_in_rails
    total_rails.times { |row_num| read_row(row_num) }
  end

  def read_rails(result = '')
    total_characters.times do
      self.going_down = true if rails_num.zero?
      self.going_down = false if rails_num == total_rails - 1
      result << rails[rails_num][rails_column_num]
      move_index
    end
    result
  end

  def read_row(row_num)
    while rails[row_num].include?(' ')
      index = rails[row_num].index(' ')
      rails[row_num][index] = sentence[0]
      self.sentence = sentence[1..]
    end
  end

  def total_characters
    rails.join.length
  end
end
