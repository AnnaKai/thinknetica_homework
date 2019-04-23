require_relative 'counter'
# Cargo Train
class CargoTrain < Train
  include InstanceCounter

  def initialize(num)
    super
    @type = 'cargo'
    validate!
  end

  def add_wagon(wagon)
    super(wagon) if wagon.is_a? CargoWagon
  end
end
