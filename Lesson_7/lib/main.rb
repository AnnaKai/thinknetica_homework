# modules
require 'menu'
require 'company'
require 'train'

require 'passenger_train'
require 'cargo_train'
require 'wagon'
require 'passenger_wagon'
require 'cargo_wagon'
require 'station'
require 'route'

class Main

  include MenuHelper

  attr_reader :train, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def launch!
    intro
    loop do
      puts "\nThis is a Main Menu where you can operate your Railroad\n"
      show_menu(MAIN_MENU)
      case gets.to_i
      when 1 then train_menu
      when 2 then route_menu
      when 3 then station_menu
      when 0 then break
      else error
      end
    end
    conclusion
  end

  private #shouldn't be used outside of the class

  def train_menu
    loop do
      show_menu(TRAIN_MENU)
      case gets.to_i
      when 1 then create_train
      when 2 then set_route
      when 3 then movement_menu
      when 4 then wagons_menu
      when 5 then train_wagon_info
      when 0 then break
      else error
      end
    end
  end

  def route_menu
    loop do
      show_menu(ROUTE_MENU)
      case gets.to_i
      when 1 then create_route
      when 2 then manage_stations
      when 0 then break
      else error
      end
    end
  end

  def station_menu
    loop do
      puts "\n>>> STATIONS MENU <<<"
      show_menu(STATION_MENU)
      case gets.to_i
      when 1 then create_station
      when 2 then display_stations
      when 3 then show_trains
      when 0 then break
      else error
      end
    end
  end

  def create_train
    puts "\n>>> TRAIN CREATION <<<"
    puts "\nNumber of your new train? Make sure, it's in xxx-xx/xxxxx format"
    train_num = gets.to_s
    puts "\nSpecify the type of your train? "
    show_menu(TRAIN_TYPE_MENU)
    case gets.to_i
    when 1 then
      @trains << PassengerTrain.new(train_num)
      puts "\nYou've created a Passenger Train #{train_num}"
    when 2 then
      @trains << CargoTrain.new(train_num)
      puts "\nYou've created a Cargo Train #{train_num}"
    end
  rescue StandardError => e
    puts e
    retry
  end

  def train_wagon_info
    if @trains.empty?
      puts "\nNo trains. Create a Train!"
    else
      puts "Select a Train to see its Info"
      trains = sort_by_value(@trains, :num)
      show_list(trains)
      train = get_item(@trains)
      puts "\nTrain has no Wagons yet" if train.wagons.empty?

      train.wagon do |wagon|
        puts "Wagon Type: #{wagon.type}, Available Capacity: #{wagon.available_capacity}, Occupied: #{wagon.capacity_usage}"
      end
    end
  end

  def create_route
    if @stations.length >= 2
      begin
      stations = sort_by_value(@stations, :name)
      show_list(stations)
      puts 'Num From: '
      from = get_item(@stations)
      puts 'Num To: '
      to = get_item(@stations)
      @routes << Route.new(from, to)
      rescue StandardError => e
        puts e
        retry
      end
    else
      print "\nCreate Stations first in order to create a Route\n"
    end
  end

  def wagons_menu
    if @trains.empty?
      print "\nYou should create a Train before you can change its Wagons\n"
    else
      puts 'Enter Train index to operate its wagons: '
      trains = sort_by_value(@trains, :num)
      show_list(trains)
      train = get_item(@trains)
      if @trains.include? train
        show_menu(WAGON_MENU)
        case gets.to_i
        when 1 then add_wagon_option(train)
        when 2 then remove_wagon_option(train)
        when 3 then change_wagon_capacity(train)
        when 0 then return
        else error
        end
      end
    end
  end

  def manage_stations
    if @routes.any?
      print "\n>>> STATION CONTROL <<<\n"
      puts "Enter Route number for editing"
      show_list(@routes)
      route = get_item(@routes)
      return if route.nil?

      puts "\nEnter Route number: "
      show_menu(ROUTE_STATIONS_MENU)
      case gets.to_i
      when 1 then add_station_to(route)
      when 2 then remove_station_from(route)
      when 0 then return
      else error
      end
    else
      print "\nNo routes. Create one first\n"
    end
  end

  def add_station_to(route)
    available_stations = @stations - route.stations
    return if available_stations.empty?

    puts "\nEnter a number of Station you'd like to add"
    available_stations = sort_by_value(available_stations, :name)
    show_list(available_stations)
    station = get_item(available_stations)
    route.add_middway(station)
  end

  def remove_station_from(route)
    puts "\nEnter number of Station to remove"

    show_list(route.stations)
    station = get_item(route.stations)
    return if route.stations.size < 3

    route.remove_middway(station)
  end

  def add_wagon_option(train)
    puts "\nPlease, Specify Wagon Capacity: "
    capacity = gets.to_i
    return if capacity <= 0

    case train.type
    when 'cargo' then
      train.add_wagon(CargoWagon.new(capacity))
    when 'passenger' then
      train.add_wagon(PassengerWagon.new(capacity))
    end
    puts "\nYou've successfully added a New Wagon with Capacity of #{capacity}"
  end

  def remove_wagon_option(train)
    if train.wagons.empty?
      print "There's no wagons to remove\n"
    else
      puts 'Choose a Wagon to remove from: '
      show_list(train.wagons)
      wagon = get_item(train.wagons)
      return if wagon.nil?

      train.remove_wagon(wagon)
      puts "You've successfully removed a wagon"
    end
  end

  def change_wagon_capacity(train)
    if train.wagons.empty?
      print "There's no Wagons to operate! Add a Wagon first\n"
    else
      puts 'Choose a Wagon: '
      show_list(train.wagons)
      wagon = get_item(train.wagons)
      return if wagon.nil?

      if wagon.type == 'Passenger'
        wagon.increase_capacity_usage(1)
        puts "You've occupied Wagon by 1"
      else
        puts "\nSpecify Capacity to occupy: "
        capacity = gets.to_i
        wagon.increase_capacity_usage(capacity)
        puts "You've occupied Wagon by #{capacity}"
      end
    end
  end

  def create_station
    puts 'Enter a new Station name: '
    station_name = gets.chomp.to_s
    @stations << Station.new(station_name)
    puts "\nYou've created a new Station -> #{station_name}\n"
  rescue StandardError => e
    puts e
    retry
  end

  def set_route
    if @routes.empty? || @trains.empty?
      print "\nYou can't set a route. You should have both a Train and a Route created\n"
    else
      print ">>> SET A ROUTE <<<\n"
      puts 'Enter Route Num: '
      show_list(@routes)
      route = get_item(@routes)
      return if route.nil?

      puts 'Enter Train Num: '
      show_list(@trains)
      train = get_item(@trains)
      return if train.nil?

      train.apply_route(route)
    end
  end

  def movement_menu
    if @trains.empty?
      print "\nThere's no trains to move\n"
    else
      print ">>> TRAIN MOVEMENT <<<\n"
      puts 'Pick a Train: '
      show_list(@trains)
      train = get_item(@trains)
      return if train.nil? || train.route.nil?

      puts 'Select where you want to move the train: '
      show_menu(MOVEMENT_MENU)
      case gets.to_i
      when 1 then train.move_forward
      when 2 then train.move_back
      when 0 then return
      else error
      end
    end
  end

  def display_stations
    if @stations.empty?
      print "\nThere's no stations\n"
    else
      puts 'Stations: '
      stations = sort_by_value(@stations, :name)
      show_list(stations)
    end
  end

  def show_trains
    if @stations.empty?
      print"\nNo stations yet\n"
    else
      puts 'Pick a Station to see parked Trains and their Info: '
      stations = sort_by_value(@stations, :name)
      show_list(stations)
      station = get_item(@stations)
      return unless station

      puts "Trains at the Station >>#{station.name}<< : "
      print "\nNo Trains\n" if station.train.empty?
      station.train { |train| puts "Train Num: #{train.num}, Type: #{train.type}, Wagons: #{train.wagons}" }
    end
  end

  def error
    puts "\nError: Unknown command. Select one of the suggested options to proceed\n"
  end

  def intro
    puts "\n\n<<< Welcome to the Rail Creator >>>\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye! >>>\n\n"
  end
end
