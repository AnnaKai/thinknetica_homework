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
