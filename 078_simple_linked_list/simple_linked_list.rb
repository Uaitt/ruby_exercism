Element = Struct.new(:datum, :next)

class SimpleLinkedList
  attr_reader :list

  def initialize(ary = [])
    @list = []
    ary.each { |datum| push(Element.new(datum)) }
  end

  def push(element)
    list.unshift(element)
    self
  end

  def pop
    list.shift
  end

  def to_a
    list.map(&:datum)
  end

  def reverse!
    list.reverse!
    self
  end
end
