class Series
  def initialize(data)
    @data = data
  end

  def slices(substring_length)
    raise(ArgumentError) if substring_length > @data.length || substring_length.to_i <= 0

    iterations = @data.length - substring_length + 1
    iterations.times.map { |i| @data[i...substring_length + i] }
  end
end
