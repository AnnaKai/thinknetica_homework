require_relative 'wagon'

class PassengerWagon < Wagon

  def initialize(capacity)
    super
    @type = 'Passenger'
  end

  def increase_capacity_usage(_capacity)
    super(1)
  end
end
