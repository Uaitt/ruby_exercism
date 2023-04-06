class Scale
  SHARP_CHROMATIC_SCALE = %w[A A# B C C# D D# E F F# G G#].freeze
  FLAT_CHROMATIC_SCALE = %w[A Bb B C Db D Eb E F Gb G Ab].freeze

  STARTING_SHARP_TONICS = %w[C G D A E B F# e b f# c# g# d# a].freeze

  STEPS = { 'm' => 1, 'M' => 2, 'A' => 3 }.freeze

  def initialize(initial_tonic)
    @initial_tonic = initial_tonic
  end

  def chromatic
    if STARTING_SHARP_TONICS.include?(initial_tonic)
      rotate(SHARP_CHROMATIC_SCALE, initial_tonic)
    else
      rotate(FLAT_CHROMATIC_SCALE, initial_tonic)
    end
  end

  def interval(intervals)
    intervals = intervals.split('')
    scale = [capitalized_initial_tonic]
    if STARTING_SHARP_TONICS.include?(initial_tonic)
      generate_scale_for(intervals, SHARP_CHROMATIC_SCALE, scale)
    else
      generate_scale_for(intervals, FLAT_CHROMATIC_SCALE, scale)
    end
    scale
  end

  private

  attr_reader :initial_tonic

  def rotate(scale, initial_tonic)
    scale.rotate(scale.index(initial_tonic))
  end

  def capitalized_initial_tonic
    return initial_tonic.capitalize if initial_tonic[0].downcase == initial_tonic[0]

    initial_tonic
  end

  def generate_scale_for(intervals, chromatic_scale, scale)
    intervals.each do |interval|
      current_index = chromatic_scale.index(scale.last)
      wanted_index = if current_index + STEPS[interval] > chromatic_scale.length - 1
                       current_index + STEPS[interval] - chromatic_scale.length
                     else
                       current_index + STEPS[interval]
                     end
      scale << chromatic_scale[wanted_index]
    end
  end
end
