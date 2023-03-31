class Bob
  class << self
    def hey(input)
      return 'Fine. Be that way!' if silence?(input)
      return 'Calm down, I know what I\'m doing!' if yelled?(input) && question?(input)
      return 'Whoa, chill out!' if yelled?(input)
      return 'Sure.' if question?(input)

      'Whatever.'
    end

    private

    def silence?(input)
      input.strip == ''
    end

    def yelled?(input)
      input.match?(/[A-Za-z]/) && input.upcase == input
    end

    def question?(input)
      input.strip[-1] == '?'
    end
  end
end
