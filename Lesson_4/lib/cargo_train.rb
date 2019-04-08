class CargoTrain < Train
  def initialize(num)
    super
    @type = 'cargo'
  end

  def add(wagon)
    add_wagon(wagon) if wagon.is_a? CargoWagon
  end
end
