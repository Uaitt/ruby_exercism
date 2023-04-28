class Dominoes
  class << self
    def chain?(dominoes)
      return true if dominoes.empty?

      chain = build_chain(dominoes)
      chain.first.first == chain.last.last && chain.length == dominoes.length
    end

    private

    def build_chain(dominoes)
      dominoes.each do |starting_domino|
        chain = [starting_domino]
        remaining_dominoes = dominoes.clone
        remaining_dominoes.delete(starting_domino)
        (dominoes.length - 1).times do
          concatenate(chain, remaining_dominoes)
          return chain if chain.length == dominoes.length
        end
      end
      [dominoes.first]
    end

    def concatenate(chain, remaining_dominoes)
      trailing_dots = chain.last.last
      chain << remaining_dominoes.delete([trailing_dots, trailing_dots]) if remaining_dominoes.include?([trailing_dots, trailing_dots])

      remaining_dominoes.each do |current_domino|
        if current_domino.first == trailing_dots
          chain << remaining_dominoes.delete_at(remaining_dominoes.index(current_domino))
          break
        end

        swap(current_domino)

        if current_domino.first == trailing_dots
          chain << remaining_dominoes.delete_at(remaining_dominoes.index(current_domino))
          break
        end
      end
    end

    def swap(domino)
      domino[1], domino[0] = domino[0], domino[1]
    end
  end
end
