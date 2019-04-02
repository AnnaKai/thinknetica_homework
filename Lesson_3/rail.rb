class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add(train)
    @trains << train
  end

  def remove(train)
    @trains.delete(train)
  end

  def show_trains_by(type)
    @trains.select {|train| train.type == type}
  end
end


class Route
  attr_reader :stations

  def initialize(a, b)
    @stations = [a, b]
  end

  def add_middway(station)
    @stations.insert(-2, station)
  end

  def remove_middway(station)
    @stations.delete(station)
  end

  def show_all_stations
    @stations.each {|station| puts station}
  end
end


class Train
  attr_accessor :speed, :wagon_num, :route

  def initialize(num, type, wagon_num)
    @num = num
    @type = type
    @wagon_num = wagon_num
    @speed = 0
  end

  def increase_speed(km)
    @speed += km if km > 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagon_num += 1 if @speed == 0
  end

  def remove_wagon
    @wagon_num -= 1 if @speed == 0 && @wagon_num > 0
  end

  def apply_route(route)
    @route = route
    @location = 0
    current_station.add(self)
  end

  def move_forward
    if next_station
      current_station.remove(self)
      next_station.add(self)
      @location += 1
    end
  end

  def move_back
    if previous_station
      current_station.remove(self)
      previous_station.add(self)
      @location -= 1
    end
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
