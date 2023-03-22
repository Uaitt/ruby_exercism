class FlattenArray
  class << self
    def flatten(ary)
      (ary || []).flatten.compact
    end
  end
end
