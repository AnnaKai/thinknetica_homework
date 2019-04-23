require_relative 'counter'
# Train Route
class Route
  include InstanceCounter
  include MenuHelper

  attr_accessor :stations

  def initialize(from, to)
    validate!(from, to)
    @stations = [from, to]
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_middway(station)
    @stations.insert(-2, station)
  end

  def remove_middway(station)
    return if [@stations.first, @stations.last].include?(station)

    @stations.delete(station)
  end

  def show_all_stations
    show_list(@stations)
  end

  protected

  def validate!(from, to)
    raise 'No Starting Point' unless from
    raise 'No Ending Point' unless to
    raise "Route Points can't be equal" if from == to

    true
  end
end
