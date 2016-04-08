# 9.rb

# If we have this class:

# class Game
#   def play
#     "Start the game!"
#   end
# end

# class Bingo < Game
#   def rules_of_play
#     #rules of play
#   end
# end

# What would happen if we added a play method
# to the Bingo class, keeping in mind that there
# is already a method of this name in the Game class 
# that the Bingo class inherits from.

#ANSWER:
# If we were to add a new play method in the Bingo class,
# it would override the one from Game. With the Method Lookup Path,
# the first place a method would be searched for is the current 
# class, and if not found then would search each Superclass until
# it found the method.

#TEST:
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "STarting Bingo..."
  end
end

bingo_game = Bingo.new
puts bingo_game.play