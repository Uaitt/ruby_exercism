class PhoneNumber
  class << self
    def clean(number)
      number.gsub!(/\D/, '')
      number = number[1..] if number[0] == '1'
      return nil unless valid?(number)

      number
    end

    def valid?(number)
      return false if number.length != 10
      return false unless number[0].between?('2', '9')
      return false unless number[3].between?('2', '9')

      true
    end
  end
end
