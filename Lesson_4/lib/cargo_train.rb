class CargoTrain < Train
  def initialize(num)
    super
    @type = 'cargo'
  end

  def add_wagon(wagon)
    super(wagon) if wagon.is_a? CargoWagon
  end
end
