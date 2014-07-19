require "dungeon.rb"

class Application
  def run(name)
    my_dungeon = Dungeon.new(name)
    install_rooms
    my_dungeon.start(rooms.first.reference)
    next_move = ""
    until next_move == "quit" or next_move == "q" do
      print "What's your next move? "
      next_move = gets.chomp.downcase

      case next_move
      when "s" then my_dungeon.go :south
      when "n" then my_dungeon.go :north
      when "w" then my_dungeon.go :west
      when "e" then my_dungeon.go :east
      when "q" || "quit" then should_you_really_quit
      else puts "Not a valid command, try again.\n"
      end
    end
  end

  def install_rooms
    my_dungeon.add_room(:largecave, "Large Cave", "a large, cavernous cave", { :west => :smallcave })
    my_dungeon.add_room(:smallcave, "Large Cave", "a small, claustrophobic cave", { :west => :smallcave, :south => :spiderlair })
    my_dungeon.add_room(:spiderlair, "Spider Lair", "a lair full of spiders", { :north => :smallcave })
  end

  def current_move_options
    options = []
    my_dungeon.player.location.connections.each do |direction, reference|
      options << direction.to_s
    end
  end

  def should_you_really_quit
    print "You're saying you want to quit, are you really sure? (Type quit to really quit): "
    answer = gets.chomp
    return break if answer == "quit"
    "\nHere we go again, you didn't say quit!\n\n"
  end
end

my_dungeon = Dungeon.new("Brandon")


my_dungeon.start(:largecave)