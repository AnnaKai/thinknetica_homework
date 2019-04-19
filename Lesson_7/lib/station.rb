require_relative 'counter'

class Station
  include InstanceCounter

  attr_accessor :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def train
    @trains.each { |train| yield(train) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add(train)
    @trains << train
  end

  def remove(train)
    @trains.delete(train)
  end

  def show_trains_by(type)
    @trains.select { |train| train.type == type }
  end

  protected

  def validate!
    raise 'No Station Name was given' if name.empty?
    raise "Station Name can't be nil" if name.nil?
    raise 'Short Station name. It should be more than 2 chars' if name.length < 2

    true
  end
end
