class PassengerTrain < Train
  def initialize(num)
    super
    @type = 'passenger'
  end
  def add_wagon(wagon)
    super(wagon) if wagon.is_a? PassengerWagon
  end
end
