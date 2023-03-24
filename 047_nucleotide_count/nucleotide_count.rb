class Nucleotide
  class << self
    def from_dna(sequence)
      raise(ArgumentError) if sequence.gsub(/[ATCG]/, '').length.nonzero?

      new(sequence)
    end
  end

  def initialize(sequence)
    @sequence = sequence || ''
  end

  def count(character)
    histogram[character]
  end

  def histogram
    histogram = { 'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0 }
    sequence.split('').each { |character| histogram[character] += 1 }
    histogram
  end

  private

  attr_reader :sequence
end
