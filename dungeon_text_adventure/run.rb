require_relative "dungeon"

class Application
  def self.run(name)
    @my_dungeon = Dungeon.new(name)
    @player = @my_dungeon.player
    self.install_rooms
    @my_dungeon.start(@my_dungeon.rooms.first.reference)
    @next_move = ""
    until @next_move == "quit" do
      begin
        print "What's your next move? "
        @next_move = gets.chomp.downcase
        case @next_move
        when "s" then @my_dungeon.go :south
        when "n" then @my_dungeon.go :north
        when "w" then @my_dungeon.go :west
        when "e" then @my_dungeon.go :east
        when "q" then self.should_you_really_quit
        else puts "Not a valid command, try again.\n"
        end
      rescue
        puts "Nothing's here, going back to #{@my_dungeon.player.previous_room}...\n"
        @player.location = @player.previous_location
      end
    end
  end

  def self.install_rooms
    @my_dungeon.add_room(:largecave, "Large Cave", "a large, cavernous cave", { :west => :smallcave })
    @my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", { :east => :largecave, :south => :spiderlair })
    @my_dungeon.add_room(:spiderlair, "Spider Lair", "a lair full of spiders", { :north => :smallcave })
  end

  def current_move_options
    options = []
    @my_dungeon.player.location.connections.each do |direction, reference|
      options << direction.to_s
    end
  end

  def self.should_you_really_quit
    print "You're saying you want to quit, are you really sure? (Type quit to really quit): "
    answer = gets.chomp
    return @next_move = "quit" if answer == "quit"
    "\nHere we go again, you didn't say quit!\n\n"
  end
end

print "\nWhat's your name? "
name = gets.chomp
Application.run(name)

