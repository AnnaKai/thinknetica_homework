require_relative 'company'
# Train Car/wagon
class Wagon
  include Company

  attr_accessor :type, :capacity, :capacity_usage

  def initialize(capacity)
    @capacity = capacity
    @capacity_usage = 0
  end

  def increase_capacity_usage(num)
    raise 'Can only be a positive number' if num < 0
    raise 'No more space available' if @capacity_usage + num > @capacity

    @capacity_usage += num
  end

  def available_capacity
    @capacity - @capacity_usage
  end
end
