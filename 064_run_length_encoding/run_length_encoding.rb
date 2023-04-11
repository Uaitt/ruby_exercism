class RunLengthEncoding
  class << self
    def encode(input, result = '', count = 0)
      current_char = input[0]
      input.chars do |char|
        (count += 1; next) if current_char == char

        add_run(result, count, current_char)
        current_char = char
        count = 1
      end
      add_run(result, count, current_char) unless input.empty?
      result
    end

    def decode(input)
      input.scan(/([0-9]*)([a-zA-Z ])/).map do |item|
        num = item[0].empty? ? 1 : item[0].to_i
        item[1] * num
      end.join
    end

    private

    def add_run(result, count, current_char)
      result << (count <= 1 ? current_char : "#{count}#{current_char}")
    end
  end
end
