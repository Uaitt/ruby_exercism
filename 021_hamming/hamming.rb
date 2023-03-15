class Hamming
  class << self
    def compute(strand1 = '', strand2 = '')
      raise(ArgumentError) if strand1.length != strand2.length

      hamming_distance = 0
      strand1.length.times { |iteration| hamming_distance += 1 if strand1[iteration] != strand2[iteration] }
      hamming_distance
    end
  end
end
