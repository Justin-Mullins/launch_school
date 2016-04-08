# rock_paper_scissors_move_history.rb
# ======================================
# come up with some rules for the computer to move based on the player's moves.

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
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
    @value
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
  # Computer.choose will look at previous player moves and make choice based on that info.
  def choose(player_move_history) # pass in player_move_history
    move_counts = Hash.new 0 # this will store how many times each move was chosen by the player.
    player_move_history.each do |move| # loop through all moves
      move_counts[move] += 1
    end
    # compare the values to see if one move is chosen more than
    # often than others.
    # If so, then computer will choose the movn
    e to block that.
    if move_counts['rock'] > move_counts['paper'] && move_counts['rock'] > move_counts['scissors']
      self.move = Move.new('paper')
    elsif move_counts['paper'] > move_counts['rock'] && move_counts['paper'] > move_counts['scissors']
      self.move = Move.new('scissors')
    elsif move_counts['scissors'] > move_counts['rock'] && move_counts['scissors'] > move_counts['paper']
      self.move = Move.new('rock')
    else  # Else, choose move at random.
      self.move = Move.new(Move::VALUES.sample) # choose move at random
    end
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :player_move_history

  def initialize
    @human = Human.new
    @computer = Computer.new
    @player_move_history = []
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
    puts "Good bye."
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  # Store player_move_history for reference in Computer.choose 
  def store_moves
    player_move_history << human.move.to_s  # player moves are stored as strings in an array
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
      computer.choose(player_move_history)
      display_moves
      store_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
