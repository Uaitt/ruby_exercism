class Say
  SPECIAL_NUMBERS = %w[zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen
                       sixteen seventeen eighteen nineteen].freeze
  TENS = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'].freeze
  SCALE = ['', 'thousand', 'million', 'billion'].freeze
  NUMBER_RANGE = (0..999_999_999_999).freeze

  def initialize(number)
    @number = number
    @triads = number.to_s.reverse.scan(/.{,3}/).map { |triad| triad.reverse.to_i }
  end

  def in_english
    raise(ArgumentError) unless NUMBER_RANGE.include?(@number)
    return 'zero' if number.zero?

    triads.each_with_index.inject('') do |result, (triad, i)|
      word = to_word(triad)
      scale = triad.zero? ? '' : SCALE[i]
      result.prepend("#{word} #{scale} ")
    end.strip
  end

  private

  attr_reader :number, :triads

  def to_word(triad)
    word = ''
    hundreds = triad / 100
    tens = (triad - hundreds * 100) / 10
    units = (triad - hundreds * 100 - tens * 10)

    word += "#{SPECIAL_NUMBERS[hundreds]} hundred " unless hundreds.zero?

    return word if tens.zero? && units.zero?

    word + if tens >= 2
             units.zero? ? TENS[tens].to_s : "#{TENS[tens]}-#{SPECIAL_NUMBERS[units]}"
           else
             special_num = tens * 10 + units
             SPECIAL_NUMBERS[special_num]
           end
  end
end
