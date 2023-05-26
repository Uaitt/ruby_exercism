class Game
  BowlingError = Class.new(StandardError)

  attr_reader :frames

  def initialize
    @frames = []
  end

  def roll(pins)
    new_frame? ? frames << Frame.new(pins) : frames.last.ball_throw(pins)
    raise(BowlingError) unless valid_roll?(pins)

    compute_scores(pins)
  end

  def score
    raise(BowlingError) if frames.length < 10 || missing_bonus_throw?

    frames.inject(0) { |total, frame| total + frame.score }
  end

  private

  def new_frame?
    frames.empty? || ((frames.last.throws == 2 || frames.last.strike?) && frames.length < 10)
  end

  def valid_roll?(pins)
    (0..10).include?(pins) && (frames.length != 10 && valid_normal_roll? || frames.length == 10 && valid_last_roll?)
  end

  def compute_scores(pins)
    return frames.last.score += pins if frames.length == 1 || frames.last.throws > 2

    previous_frame = frames[-2]

    if previous_frame.strike? || (previous_frame.spare? && frames.last.throws == 1)
      frames[-3].score += pins if three_strikes_in_a_row?

      previous_frame.score += pins
    end

    frames.last.score += pins
  end

  def missing_bonus_throw?
    last_frame = frames.last
    last_frame.strike? || last_frame.spare? && last_frame.throws <= 2 ||
      last_frame.pins == 20 && last_frame.throws == 2
  end

  def valid_normal_roll?
    (frames.empty? || frames.last.pins <= 10)
  end

  def valid_last_roll?
    (frames.last.throws <= 2 || frames.last.pins >= 10) &&
      (frames.last.pins <= 20 && frames.last.throws <= 3 || (frames.last.score % 10).zero?)
  end

  def three_strikes_in_a_row?
    frames.length > 2 && frames[-3].strike? && frames.last.throws == 1
  end
end

class Frame
  attr_accessor :score, :pins, :throws

  def initialize(pins)
    @score = 0
    @pins = pins
    @throws = 1
  end

  def ball_throw(pins)
    @pins += pins
    @throws += 1
  end

  def strike?
    pins == 10 && throws == 1
  end

  def spare?
    pins == 10 && throws == 2
  end
end
