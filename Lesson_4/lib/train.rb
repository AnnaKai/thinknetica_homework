class Train
  attr_accessor :speed, :route, :wagons
  attr_reader :type

  def initialize(num)
    @num = num
    @speed = 0
    @wagons = []
  end

  def increase_speed(km)
    @speed += km if km > 0
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

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero?
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end

  protected #shouldn't be used outside of the class and its children

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
