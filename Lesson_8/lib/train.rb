require_relative "company"
require_relative "counter"
# Train
class Train
  include InstanceCounter
  include Company

  class << self; attr_accessor :trains; end

  attr_accessor :speed, :route, :wagons, :num
  attr_reader :type

  TRAIN_NUM_FORMAT = /^[0-9a-zA-Z]{3}-?[0-9a-zA-Z]{2}$/i.freeze

  @trains = {}

  def initialize(num)
    @num = num
    validate!
    @speed = 0
    @wagons = []
    Train.trains[num] = self
    register_instance
  end

  def wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.find(num)
    @trains[num]
  end

  def increase_speed(num)
    @speed += num if num.positive?
  end

  def stop
    @speed = 0
  end

  def apply_route(route)
    @route = route
    @location = 0
    current_station.add(self)
  end

  def move_forward
    return unless next_station

    current_station.remove(self)
    next_station.add(self)
    @location += 1
  end

  def move_back
    return unless previous_station

    current_station.remove(self)
    previous_station.add(self)
    @location -= 1
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero?
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end

  protected # shouldn't be used outside of the class and its children

  def validate!
    raise "Train Number has invalid format" if num !~ TRAIN_NUM_FORMAT

    true
  end

  def current_station
    @route.stations[@location]
  end

  def next_station
    @route.stations[@location + 1] if @location < @route.stations.length
  end

  def previous_station
    @route.stations[@location - 1] if @location > 0
  end
end
