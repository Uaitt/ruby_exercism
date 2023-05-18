class IsbnVerifier
  VALID_ISB_FORMAT = /^\d{9}[\dX]$/.freeze
  class << self
    def valid?(code)
      code.gsub!('-', '')

      return false if !code.match?(VALID_ISB_FORMAT) || code.length != 10

      last_value = (code[-1] == 'X' ? 10 : code[-1].to_i)
      code = code.chars.map!(&:to_i)
      (formula_for(code, last_value) % 11).zero?
    end

    private

    def formula_for(code, last_value)
      code[0...-1].each_with_index.inject(last_value) { |sum, (val, ind)| sum + val * (10 - ind) }
    end
  end
end
