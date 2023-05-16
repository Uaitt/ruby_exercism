class Series
  def initialize(sequence)
    @sequence = sequence
  end

  def largest_product(span)
    raise(ArgumentError) if span.negative? || span > sequence.length || sequence.match?(/[A-Za-z]/)

    series(span).map { |sequence| sequence.inject(&:*) }.max
  end

  private

  attr_reader :sequence

  def series(span)
    [*0..sequence.length - span].map { |count| sequence[count..span + count - 1].chars.map(&:to_i) }
  end
end
