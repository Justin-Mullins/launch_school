class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (ie, 'X' or 'O')
  end

  def flip

  end

  def play

  end

  def match

  end
end

class MemoryGame
  def display_welcome_message
    puts "Welcome to the game, Memory!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end

  def display_board
    puts " ____   ____   ____   ____   ____   ____   ____   ____"
    puts "|    | |    | |    | |    | |    | |    | |    | |    |"
    puts "|    | |    | |    | |    | |    | |    | |    | |    |"
    puts "|____| |____| |____| |____| |____| |____| |____| |____|"
    puts " ____   ____   ____   ____   ____   ____   ____   ____"
    puts "|    | |    | |    | |    | |    | |    | |    | |    |"
    puts "|    | |    | |    | |    | |    | |    | |    | |    |"
    puts "|____| |____| |____| |____| |____| |____| |____| |____|"
    puts " ____   ____   ____   ____   ____   ____   ____   ____"
    puts "|    | |    | |    | |    | |    | |    | |    | |    |"
    puts "|    | |    | |    | |    | |    | |    | |    | |    |"
    puts "|____| |____| |____| |____| |____| |____| |____| |____|"
  end

  def play
    display_welcome_message
    loop do
      display_board
      player_picks_tile
      player_picks_tile
      found_match?
      break if board_empty?
    end
    display_result
    display_goodbye_message
  end
end

# we'll kick off the game like this
game = MemoryGame.new
game.play
