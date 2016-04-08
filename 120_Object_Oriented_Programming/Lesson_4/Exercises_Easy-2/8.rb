# 8.rb

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

# And another class:

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What can we add to the Bingo class to allow it
# to inherit the play method from the Game class?

#ANSWER:
# make the Bingo class a subclass of the Game class, then you can
# the methods from the other class.

#TEST
new_game = Bingo.new
puts new_game.play