class InvalidCodonError < ArgumentError; end

class Translation
  CODONS = { 'Methionine' => %w[AUG], 'Phenylalanine' => %w[UUU UUC], 'Leucine' => %w[UUA UUG],
                            'Serine' => %w[UCU UCC UCA UCG], 'Tyrosine' => %w[UAU UAC], 'Cysteine' => %w[UGU UGC],
                            'Tryptophan' => %w[UGG] }.freeze
  STOP_CODONS = %w[UAA UAG UGA].freeze

  class << self
    def of_rna(rna, proteins = [])
      codons = rna.chars.each_slice(3).map(&:join)

      codons.each do |codon|
        break if STOP_CODONS.include?(codon)

        current_protein = CODONS.keys.select { |protein| CODONS[protein].include?(codon) }
        raise(InvalidCodonError) if current_protein.empty?

        proteins << current_protein
      end
      proteins.flatten
    end
  end
end
