require_relative 'counter'

class Route
  include InstanceCounter

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
    unless [@stations.first, @stations.last].include?(station)
      @stations.delete(station)
    end
  end

  def show_all_stations
    @stations.each { |station| puts station }
  end

  protected

  def validate!(from, to)
    raise "No Starting Point" if from.nil?
    raise "No Ending Point" if to.nil?
    raise "Route Points can't be equal" if from == to

    true
  end
end
