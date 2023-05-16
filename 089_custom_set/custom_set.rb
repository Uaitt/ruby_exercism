class CustomSet
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def empty?
    data.empty?
  end

  def member?(value)
    data.include?(value)
  end

  def subset?(other)
    (data - other.data).empty?
  end

  def disjoint?(other)
    (data + other.data).uniq == data + other.data
  end

  def ==(other)
    data.sort == other.data.sort
  end

  def add(value)
    unless data.include?(value)
      data.push(value)
      data.sort!
    end
    self
  end

  def intersection(other)
    CustomSet.new(data.intersection(other.data))
  end

  def difference(other)
    CustomSet.new(data - other.data)
  end

  def union(other)
    CustomSet.new((data + other.data).uniq)
  end
end
