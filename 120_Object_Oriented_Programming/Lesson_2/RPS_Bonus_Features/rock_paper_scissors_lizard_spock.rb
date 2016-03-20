# rock_paper_scissors_lizard_spock.rb
# ===================================
# Adding lizard and spock to the rock paper scissors game.

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

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

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    # rock beats scissors and lizard
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      # paper beats rock and spock
      (paper? && (other_move.rock? || other_move.spock?)) ||
      # scissors beats paper and lizard
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      # lizard beats paper and spock
      (lizard? && (other_move.paper? || other_move.spock?)) ||
      # spock beats rock and scissors
      (spock? && (other_move.rock? || other_move.scissors?)) 
  end

  def <(other_move)
    # rock loses to paper and spock
    (rock? && (other_move.paper? || other_move.spock?)) ||
      # paper loses to scissors and lizard
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      # scissors loses to rock and spock
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      # lizard loses to rock and scissors
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      # spock loses to paper and lizard
      (spock? && (other_move.paper? || other_move.lizard?))
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
      puts "Please choose rock, paper, scissors, lizard, or spock:"
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
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock!"
    puts "Good bye."
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
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
