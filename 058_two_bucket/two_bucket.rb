class TwoBucket
  attr_reader :moves

  def initialize(capacity_one, capacity_two, wanted_liters, first_bucket)
    setup_buckets(capacity_one, capacity_two, first_bucket)
    @wanted_liters = wanted_liters
    @first_bucket = first_bucket
    solve
  end

  def goal_bucket
    return 'one' if bucket_one.current_liters == wanted_liters && first_bucket == 'one'

    'two'
  end

  def other_bucket
    return bucket_two.current_liters if bucket_one.current_liters == wanted_liters

    bucket_one.current_liters
  end

  private

  attr_reader :bucket_one, :bucket_two, :wanted_liters, :first_bucket

  def setup_buckets(capacity_one, capacity_two, first_bucket)
    @bucket_one = Bucket.new(capacity_one, 0)
    @bucket_two = Bucket.new(capacity_two, 0)
    @bucket_one, @bucket_two = @bucket_two, @bucket_one unless first_bucket == 'one'
  end

  def solve
    bucket_one.fill!
    @moves = 1
    until bucket_one.current_liters == wanted_liters || bucket_two.current_liters == wanted_liters
      if bucket_one.empty?
        bucket_one.fill!
      elsif bucket_two.capacity == wanted_liters
        bucket_two.fill!
      elsif !bucket_two.full?
        bucket_one.pour!(bucket_two)
      else
        bucket_two.empty!
      end
      @moves += 1
    end
  end
end

class Bucket
  attr_reader :capacity
  attr_accessor :current_liters

  def initialize(capacity, current_liters)
    @capacity = capacity
    @current_liters = current_liters
  end

  def fill!
    self.current_liters = capacity
  end

  def empty!
    self.current_liters = 0
  end

  def pour!(bucket)
    delta = [bucket.capacity - bucket.current_liters, current_liters].min
    self.current_liters -= delta
    bucket.current_liters += delta
  end

  def full?
    current_liters == capacity
  end

  def empty?
    current_liters.zero?
  end
end
