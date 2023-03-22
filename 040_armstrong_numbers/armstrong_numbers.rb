class ArmstrongNumbers
  class << self
    def include?(number)
      digits = number.to_s.split('').map(&:to_i)
      number == digits.inject(0) { |sum, digit| sum + digit**digits.length }
    end
  end
end
