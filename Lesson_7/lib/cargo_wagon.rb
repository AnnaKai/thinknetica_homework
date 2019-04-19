require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(capacity)
    super
    @type = 'Cargo'
  end
end
