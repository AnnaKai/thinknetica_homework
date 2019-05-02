require_relative "wagon"
# Cargo Car
class CargoWagon < Wagon
  def initialize(capacity)
    super
    @type = "Cargo"
  end
end
