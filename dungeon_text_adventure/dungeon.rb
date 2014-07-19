class Dungeon
  
  attr_accessor :player
  attr_reader :rooms

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |r| r.reference == reference }
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    puts "You decide to go #{direction.to_s}...\n\n"
    @player.previous_location = @player.location
    @player.previous_room = (@rooms.detect {|r| r.reference == @player.previous_location}).name
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  class Player
    attr_accessor :name, :location, :previous_location, :previous_room

    def initialize(name)
      @name = name
    end
  end

  class Room
    attr_accessor :reference, :description, :name, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      "\n#{@name}\n\tYou are in #{@description}.\n\n"
    end
  end
end