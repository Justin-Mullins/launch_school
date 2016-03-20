# rock_paper_scissors_classes.rb
# ===============================
# Add new classes for Rock, Paper, and Scissors. How would the code
# change? How would you make it work? Was it a good design decision?
# What are the pros/cons?
# ===================================================================
# When I added the Rock, Paper, and Scissors classes I had to
# change code to handle the classes rather than the strings
# that I was dealing with before.
#
# Most of what I changed was in the Move class code.
# I changed the initialize method code to store the classes
# for Move, and I had to change the way I checked for the move
# value. I had to use instance_of to check what class the move
# was.
# 
# I also had to add the Rock, Paper, Scissors classes themselves.
# I just put an initialize and to_s methods in the classes.
# The initialize stores the string value, and the to_s is so I
# could print out what moves were chosen.
#
# Was it a good design decision? I'm not sure if them having their
# own classes is necessary. It doesn't seem to make the code more
# consise and their isn't a lot of code that I ended up putting in
# the classes. Maybe had I not had the move class then I could 
# have put some of that code in the Rock, Paper, Scissors classes,
# but the Move class is a better way of doing it.

require 'pry'

class Rock
  def initialize
    @value = 'rock'
  end

  def to_s
    'rock'
  end
end

class Paper
  def initialize
    @value = 'paper'
  end

  def to_s
    'paper'
  end
end

class Scissors
  def initialize
    @value = 'scissors'
  end

  def to_s
    'scissors'
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    if value == 'rock'
      @value = Rock.new
    elsif value == 'scissors'
      @value = Scissors.new
    elsif value == 'paper'
      @value = Paper.new
    end
  end

  def scissors?
    @value.instance_of? Scissors
  end

  def rock?
    @value.instance_of? Rock
  end

  def paper?
    @value.instance_of? Paper
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value.to_s
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    @move = nil
    set_name
  end
end

class Human < Player
  def choose
    # Human chooses move
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end

  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end
end

class Computer < Player
  def choose
    self.move = Move.new(Move::VALUES.sample)
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
    puts "Good bye."
  end

  def display_moves
    puts "#{human.name} chose #{human.move.to_s}."
    puts "#{computer.name} chose #{computer.move.to_s}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return true if answer == 'y'
    return false if answer == 'n'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
