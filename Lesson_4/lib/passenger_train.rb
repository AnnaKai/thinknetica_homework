class PassengerTrain < Train
  def initialize(num)
    super
    @type = 'passenger'
  end
  def add(wagon)
    add_wagon(wagon) if wagon.is_a? PassengerWagon
  end
end
