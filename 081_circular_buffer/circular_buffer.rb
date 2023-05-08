class CircularBuffer
  BufferEmptyException = Class.new(StandardError)
  BufferFullException = Class.new(StandardError)

  def initialize(length)
    @length = length
    @queue = []
  end

  def read
    raise(BufferEmptyException) if queue.empty?

    queue.shift
  end

  def write(value)
    raise(BufferFullException) if queue.length == length

    @queue.push(value)
  end

  def write!(value)
    if queue.length != length
      write(value)
    else
      queue.shift
      queue.push(value)
    end
  end

  def clear
    queue.clear
  end

  private

  attr_reader :queue, :length
end
