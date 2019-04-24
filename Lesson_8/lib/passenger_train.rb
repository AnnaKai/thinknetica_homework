require_relative "counter"
# Passenger Train
class PassengerTrain < Train
  include InstanceCounter

  def initialize(num)
    super
    @type = "passenger"
    validate!
  end

  def add_wagon(wagon)
    super(wagon) if wagon.is_a? PassengerWagon
  end
end
