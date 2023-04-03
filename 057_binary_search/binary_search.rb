class BinarySearch
  def initialize(list)
    @list = list
  end

  def search_for(num, low = 0, high = list.size - 1)
    return nil if low > high

    middle = (low + high) / 2
    return middle if list[middle] == num

    if list[middle] > num
      search_for(num, low, middle - 1)
    else
      search_for(num, middle + 1, high)
    end
  end

  private

  attr_reader :list
end
