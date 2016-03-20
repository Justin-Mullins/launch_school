# rock_paper_scissors_computer_personalities.rb
# ===============================================
# Code different moves for the different computer personalities.
# For example, R2D2 chooses rock more often than other moves.


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
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    if self.name ==  'R2D2'
      choice = move_ratio(10, 4, 6).sample
    elsif self.name == 'Hal'
      choice = move_ratio(3, 5, 8).sample
    elsif self.name == 'Chappie'
      choice = move_ratio(7, 4, 5).sample
    elsif self.name == 'Sonny'
      choice = move_ratio(8, 6, 7).sample
    elsif self.name == 'Number 5'
      choice = move_ratio(7, 3, 4).sample
    end
    self.move = Move.new(choice)
    # self.move = Move.new(Move::VALUES.sample)
  end

  # move_ratio takes in the different ratios of rock, paper, and scissors's likelihood
  # of being chosen, and returns an array with the possible choices. 
  def move_ratio(rock_ratio, paper_ratio, scissors_ratio)
    ratio = []
    ratio.fill('rock', ratio.size, rock_ratio)
    ratio.fill('paper', ratio.size, paper_ratio)
    ratio.fill('scissors', ratio.size, scissors_ratio)
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
