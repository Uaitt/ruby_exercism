class Deque
  def initialize
    @data = []
  end

  def push(value)
    data << value
  end

  def pop
    data.pop
  end

  def unshift(value)
    data.unshift(value)
  end

  def shift
    data.shift
  end

  private

  attr_reader :data
end
