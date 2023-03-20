class ResistorColor
  COLORS = %w[black brown red orange yellow green blue violet grey white].freeze

  class << self
    def color_code(color)
      COLORS.index(color)
    end
  end
end
