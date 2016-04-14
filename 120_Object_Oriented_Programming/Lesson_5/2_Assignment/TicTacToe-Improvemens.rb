# TicTacToe.rb
require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagnals

  def initialize
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new(Square::INITIAL_MARKER)}
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def count_marker(squares, marker)
    squares.collect(&:marker).count(marker)
  end

  def draw
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |     "
    puts "-----------------"
    puts "     |     |     "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |     "
    puts "-----------------"
    puts "     |     |     "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |     "
  end

  # return winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      TTTGame::MARKERS.each do |marker|
        return marker if count_marker(@squares.values_at(*line), marker) == 3
      end
    end
    nil
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new(Square::INITIAL_MARKER)}
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER 
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def mark
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  MARKERS = ["X", "O"]

  attr_reader :board, :human, :computer, :current_player

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = ['human', 'computer']
  end

  private
  # Private Methods

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_board
    puts "You're #{human.marker}'s. Computer is #{computer.marker}'s."
    puts ""
    board.draw
  end

  # This method joins an array's elements with commas 
  # except for the last element has 'or' before it
  def joinor(array, separator=', ', final_separator='or')
    string = ''
    if array.length <= 1
      return array.join
    elsif array.length > 2
      string = array.first(array.length - 2).join("#{separator}") + "#{separator}"
    end  
    string += array.last(2).join(" #{final_separator} ")
  end

  def human_moves
    puts "Choose a square #{joinor(board.unmarked_keys)}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def current_player_moves
    human_moves if human_turn?
    computer_moves if computer_turn?
    current_player.reverse! 
  end

  def human_turn?
    current_player[0] == 'human'
  end

  def computer_turn?
    current_player[0] == 'computer'
  end

  def display_result
    clear_screen_and_display_board
    
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def clear_screen
    system 'clear'
  end

  def reset
    board.reset
    clear_screen
    puts "Let's play again!"
    puts ""
  end

  public
  # Public Methods

  def play
    display_welcome_message
    clear_screen

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end
      display_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play