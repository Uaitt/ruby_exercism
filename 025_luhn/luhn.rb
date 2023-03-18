class Luhn
  class << self
    def valid?(input)
      input.gsub!(/\s/, '')
      return false if input.length <= 1 || input.match?(/\D/)

      double_second_digits(input)
      (input.split('').map(&:to_i).sum % 10).zero?
    end

    private

    def double_second_digits(input)
      index = -2
      until input[index].nil?
        input[index] = if input[index].to_i * 2 > 9
                         (input[index].to_i * 2 - 9).to_s
                       else
                         (input[index].to_i * 2).to_s
                       end
        index -= 2
      end
    end
  end
end
