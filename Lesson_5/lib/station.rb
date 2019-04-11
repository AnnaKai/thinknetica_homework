require_relative 'counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
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
end

