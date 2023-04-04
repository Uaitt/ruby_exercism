class BaseConverter
  class << self
    def convert(input_base, digits, output_base)
      raise(ArgumentError) if invalid_base?(input_base) || invalid_base?(output_base) || invalid_digits?(digits, input_base)

      decimal_num = input_base == 10 ? digits.join.to_i : convert_to_decimal(digits, input_base)
      convert_from_decimal(decimal_num, output_base)
    end

    private

    def invalid_base?(base)
      base <= 1
    end

    def invalid_digits?(digits, input_base)
      digits.any?(&:negative?) || digits.any? { |digit| digit >= input_base }
    end

    def convert_to_decimal(digits, input_base)
      digits.each_with_index.inject(0) do |sum, (digit, index)|
        sum + digit * input_base**(digits.length - 1 - index)
      end
    end

    def convert_from_decimal(decimal_num, output_base)
      quotient, remainder = decimal_num.divmod(output_base)
      digits = [remainder]
      until quotient < remainder || quotient.zero?
        quotient, remainder = quotient.divmod(output_base)
        digits.prepend(remainder)
      end
      digits.prepend(quotient) unless quotient.zero?
      digits
    end
  end
end

