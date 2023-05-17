class Poker
  attr_reader :hands

  def initialize(hands)
    @hands = hands.map { |hand| Hand.new(hand) }
  end

  def best_hand
    max_score = hands.max { |a, b| a.score <=> b.score }.score
    max_score_hands = hands.select { |hand| hand.score == max_score }
    max_hand = max_score_hands.max { |a, b| a.tie_break <=> b.tie_break }
    if tie?(max_score_hands, max_hand)
      max_score_hands.select { |hand| hand.tie_break == max_hand.tie_break }.map(&:hand)
    else
      [max_hand.hand]
    end
  end

  private

  def tie?(max_score_hands, max_hand)
    (max_score_hands.count { |hand| hand.tie_break == max_hand.tie_break }) > 1
  end
end

class Hand
  CATEGORIES = %i[straight_flush four_of_a_kind full_house flush straight
                  three_of_a_kind two_pair one_pair high_card].freeze
  RANKS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].freeze

  attr_reader :hand, :ranks, :seeds, :score, :tie_break

  def initialize(hand)
    @hand = hand
    @ranks = hand.map { get_rank(_1[0...-1]) }.sort
    convert_aces if ranks.include?(14)
    @seeds = hand.map { _1[-1] }
    calculate_score
  end

  def calculate_score
    CATEGORIES.each { |category| return send("#{category}_score") if send("#{category}?") }
  end

  def straight_flush?
    flush? && straight?
  end

  def straight_flush_score
    flush_score
    @score = 8
  end

  def four_of_a_kind?
    ranks.uniq.length == 2 && ranks.any? { |rank| ranks.count(rank) == 4 }
  end

  def four_of_a_kind_score
    @score = 7
    quad = ranks.find { |rank| ranks.count(rank) == 4 }
    wildcard = (ranks - [quad]).first
    @tie_break = quad * 10 + wildcard
  end

  def full_house?
    ranks.uniq.length == 2
  end

  def full_house_score
    @score = 6
    triplet = ranks.find { |rank| ranks.count(rank) == 3 }
    pair = (ranks - [triplet]).first
    @tie_break = triplet * 10 + pair
  end

  def flush?
    seeds.all? { |seed| seed == seeds.first }
  end

  def flush_score
    @score = 5
    @tie_break = ranks.sort.reverse.join.to_i
  end

  def straight?
    RANKS.each_cons(ranks.length).any?(&ranks.method(:==))
  end

  def straight_score
    @score = 4
    @tie_break = ranks.max
  end

  def three_of_a_kind?
    ranks.uniq.length == 3 && ranks.any? { |rank| ranks.count(rank) == 3 }
  end

  def three_of_a_kind_score
    @score = 3
    triplet = ranks.find { |rank| ranks.count(rank) == 3 }
    @tie_break = triplet + (ranks - [triplet]).max
  end

  def two_pair?
    ranks.uniq.length == 3
  end

  def two_pair_score
    @score = 2
    pair1 = ranks.find { |rank| ranks.count(rank) == 2 }
    pair2 = (ranks - [pair1]).find { |rank| ranks.count(rank) == 2 }
    wildcard = (ranks - [pair1, pair2]).first
    @tie_break = pair2 * 100 + pair1 * 10 + wildcard
  end

  def one_pair?
    ranks.uniq.length == 4
  end

  def one_pair_score
    @score = 1
    @tie_break = ranks.find { |rank| ranks.count(rank) == 2 }
  end

  def high_card?
    true
  end

  def high_card_score
    @score = 0
    @tie_break = ranks.reverse.insert(1, '.').join.to_f
  end

  private

  def get_rank(rank)
    case rank
    when 'J' then 11
    when 'Q' then 12
    when 'K' then 13
    when 'A' then 14
    else rank.to_i
    end
  end

  def convert_aces
    return unless (ranks - [2, 3, 4, 5]).length == 1

    index = ranks.index(14)
    ranks[index] = 1
    ranks.sort!
  end
end
