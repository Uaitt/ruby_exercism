class Affine
  M = 26

  attr_reader :a_key, :b_key

  def initialize(a_key, b_key)
    raise(ArgumentError) unless coprime?(a_key, M)

    @a_key = a_key
    @b_key = b_key
  end

  def encode(input, res = '')
    input = input.gsub(/[^a-zA-z0-9]/, '').downcase
    input.chars.each_with_index do |letter, index|
      res << (Integer(letter, exception: false) ? letter : encryption_for(letter))
      res << ' ' if ((index + 1) % 5).zero?
    end
    res.strip
  end

  def decode(input)
    input = input.gsub(/[^a-zA-z0-9]/, '').downcase
    input.chars.inject('') { |res, letter| res + (Integer(letter, exception: false) ? letter : decryption_for(letter)) }
  end

  private

  def coprime?(num1, num2)
    num1.gcd(num2) == 1
  end

  def encryption_for(letter)
    i = letter.ord - 'a'.ord
    num = (a_key * i + b_key) % M
    ('a'.ord + num).chr
  end

  def decryption_for(letter)
    y = letter.ord - 'a'.ord
    num2 = mmi(a_key, M) * (y - b_key) % M
    ('a'.ord + num2).chr
  end

  def mmi(num1, num2)
    (0..num2).each { |x| return x if (num1 * x) % num2 == 1 }
  end
end
