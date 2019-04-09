# Menu Items
module MenuHelper
  # Main menus
  MAIN_MENU = %w[Trains Routes Stations].freeze
  TRAIN_MENU = ['Create a Train', 'Set a Route', 'Move a Train', 'Operate Wagons'].freeze
  STATION_MENU = ['Create a Station', 'Show all Stations', 'Show Trains at the Station'].freeze
  ROUTE_MENU = ['Create a Route', 'Manage Stations'].freeze

  # Submenus
  ROUTE_STATIONS_MENU = ['Add a Station', 'Remove a Station'].freeze
  TRAIN_TYPE_MENU = %w[Passenger Cargo].freeze
  WAGON_MENU = ['Add a Wagon', 'Remove a wagon'].freeze
  MOVEMENT_MENU = ['Move the Train forward', 'Move the Train back'].freeze

  # Helpers
  def show_menu(item)
    puts "\n"
    item.each.with_index(1) { |op, index| puts "Type #{index} to #{op}" }
    puts "Type 0 or any key to return \n\n"
  end

  def show_list(data)
    if data.empty?
      puts 'None'
    else
      data.each.with_index(1) do |item, index|
        puts "#{index} —> #{item}\n"
      end
    end
  end

  def sort_by_value(array, value)
    array.map(&value)
  end

  def get_item(data)
    num = gets.to_i
    data[num - 1]
  end
end
