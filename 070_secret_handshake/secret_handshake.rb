class SecretHandshake
  SECRETS = { 1 => 'jump', 2 => 'close your eyes', 3 => 'double blink', 4 => 'wink' }.freeze

  def initialize(num)
    return unless Integer(num, exception: false)

    @binary_num = num.to_s(2)
    self.binary_num = binary_num.rjust(5, '0') if binary_num.length <= 5
  end

  def commands(secret = [])
    return [] unless binary_num

    digits = binary_num[-5..]
    digits.chars.each_with_index do |digit, index|
      next if digit.to_i.zero?

      @reverse = true if index.zero?

      secret << SECRETS[index] if SECRETS[index]
    end

    reverse ? secret : secret.reverse
  end

  private

  attr_accessor :binary_num
  attr_reader :reverse
end

