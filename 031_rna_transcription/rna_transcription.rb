class Complement
  DNA_TO_RNA = {
    'C' => 'G',
    'G' => 'C',
    'T' => 'A',
    'A' => 'U'
  }.freeze

  class << self
    def of_dna(dna)
      dna.split('').map { |nucleotide| DNA_TO_RNA[nucleotide] }.join
    end
  end
end
