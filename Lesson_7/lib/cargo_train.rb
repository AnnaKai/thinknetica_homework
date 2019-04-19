require_relative 'train'
require_relative 'counter'

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
