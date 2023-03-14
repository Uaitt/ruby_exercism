class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze
  UnsupportedOperation = Class.new(StandardError)

  class << self
    def calculate(first_operand, second_operand, operation)
      raise(UnsupportedOperation) if invalid_operation?(operation)

      raise(ArgumentError) if invalid_operands?(first_operand, second_operand)

      begin
        "#{first_operand} #{operation} #{second_operand} = #{first_operand.send(operation, second_operand)}"
      rescue ZeroDivisionError
        'Division by zero is not allowed.'
      end
    end

    private

    def invalid_operation?(operation)
      !%w[+ * /].include?(operation)
    end

    def invalid_operands?(first_operand, second_operand)
      !first_operand.is_a?(Numeric) || !second_operand.is_a?(Numeric)
    end
  end
end
