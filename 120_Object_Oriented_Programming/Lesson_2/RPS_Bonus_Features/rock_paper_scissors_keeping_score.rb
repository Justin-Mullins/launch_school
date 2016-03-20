# rock_paper_scissors:_keeping_score.rb
# ======================================
# Add functionality to program to keep score.
# First to 10 points wins.
# Should score be a new class or a state of an existing class?

# ============================================================
# Through testing out a couple of different ways, I found
# that adding a score instance variable to the Player class
# was the easiest way to implement a running scrore for each player.

# I could have also made a score class with a display and update methods
# but I felt like I wasn't doing enough with the score to make it worthwhile
# to make it a new class.

# It made sense to make Move it's own class because it helped consolidate and
# organize some critical code, but code related to the score is very simple
# and only a few lines.

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
  attr_accessor :move, :name, :score

  def initialize
    @move = nil
    @score = 0
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
    puts "First to 10 points wins!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
    puts "Good bye."
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} score's a point!"
    elsif human.move < computer.move
      puts "#{computer.name} score's a point!"
    else
      puts "It's a tie!"
    end
  end

  def display_overall_winner
    if human.score == 10
      puts "#{human.name} wins the game!" 
    elsif computer.score == 10
      puts "#{computer.name} wins the game!"
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

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def display_score
    puts "Score: #{human.name} - #{human.score}   #{computer.name} - #{computer.score}"
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      update_score
      display_score
      break unless human.score < 10 && computer.score < 10 && play_again?
    end
    display_overall_winner
    display_goodbye_message
  end
end

RPSGame.new.play
