require_relative 'counter'

class Route
  include InstanceCounter

  attr_accessor :stations

  def initialize(from, to)
    @stations = [from, to]
    register_instance
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
end
