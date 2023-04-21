class ListOps
  class << self
    def arrays(ary)
      ary.inject(0) { _1 + 1 }
    end

    def reverser(ary)
      (arrays(ary) - 1).downto(0).map { |i| ary[i] }
    end

    def concatter(ary1, ary2)
      ary1 + ary2
    end

    def mapper(ary)
      ary.each_with_object([]) { |item, result| result << (yield item) }
    end

    def filterer(ary)
      ary.each_with_object([]) { |item, result| result << item if yield item }
    end

    def sum_reducer(ary)
      ary.inject(0) { |sum, item| sum + item }
    end

    def factorial_reducer(ary)
      ary.inject(1) { |factorial, item| factorial * item }
    end
  end
end
