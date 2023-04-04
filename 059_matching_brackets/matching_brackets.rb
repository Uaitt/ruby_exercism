class Brackets
  BRACKETS = { '(' => ')', '[' => ']', '{' => '}' }.freeze

  class << self
    def paired?(input, open_brackets = [])
      brackets = input.scan(/[\[{}()\]]/)
      brackets.each do |bracket|
        if BRACKETS.keys.include?(bracket)
          open_brackets << bracket
        else
          matching_index = last_matching_bracket(bracket, open_brackets)
          return false unless matching_index == open_brackets.length - 1

          open_brackets.slice!(-1)
        end
      end
      open_brackets.empty?
    end

    private

    def last_matching_bracket(bracket, open_brackets)
      bracket = BRACKETS.key(bracket)
      open_brackets.rindex(bracket)
    end
  end
end
