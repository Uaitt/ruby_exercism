class Garden
  SEEDS = { 'G' => :grass, 'C' => :clover, 'R' => :radishes, 'V' => :violets }.freeze
  CHILDREN = %w[alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry].freeze

  def initialize(garden)
    first_row_seeds = garden.split("\n").first.scan(/.{,2}/)
    second_row_seeds = garden.split("\n").last.scan(/.{,2}/)
    @garden = first_row_seeds.zip(second_row_seeds).map(&:flatten).map(&:join)[0...-1]
    define_children
  end

  private

  attr_reader :garden

  def define_children
    garden.each_with_index do |seeds, index|
      define_singleton_method(CHILDREN[index]) do
        seeds.chars.map { |seed| SEEDS[seed] }
      end
    end
  end
end
