require_relative 'train'
require_relative 'counter'

class PassengerTrain < Train
  include InstanceCounter

  def initialize(num)
    super
    @type = 'passenger'
  end

  def add_wagon(wagon)
    super(wagon) if wagon.is_a? PassengerWagon
  end
end
