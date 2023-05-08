class Change
  NegativeTargetError = Class.new(StandardError)
  ImpossibleCombinationError = Class.new(StandardError)

  class << self
    def generate(coins, change)
      raise(NegativeTargetError) if change.negative?
      return [] if change.zero?

      new(coins, change).generate
    end
  end

  def initialize(coins, change)
    @coins = coins.select { |coin| coin <= change }
    @change = change
    @combinations = []
  end

  def generate
    coins.reverse_each { |starting_coin| combination_for(coins[0..coins.index(starting_coin)], starting_coin, change) }
    combinations.empty? ? raise(ImpossibleCombinationError) : combinations.min { |x, y| x.length <=> y.length }
  end

  private

  attr_reader :coins, :change, :combinations

  def combination_for(coins, starting_coin, change)
    change -= starting_coin
    combination = [starting_coin]
    until change.zero?
      coin = get_coin(coins, change)
      return unless coin

      combination.unshift(coin)
      change -= coin
    end
    combinations << combination
  end

  def get_coin(coins, change)
    coins.reverse.find do |coin|
      future_change = change - coin
      future_change.zero? || coin <= change && coins.min <= future_change &&
        valid_change?(coins[0..coins.index(coin)], future_change)
    end
  end

  def valid_change?(coins, change)
    coins.sum <= change || coins.any? { |coin| (change % coin).zero? }
  end
end
