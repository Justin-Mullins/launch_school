# TicTacToe.rb

require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagnals

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(Square::INITIAL_MARKER) }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
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

  def draw_middle_of_board
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
  end

  def draw
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    draw_middle_of_board
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    draw_middle_of_board
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
    (1..9).each { |key| @squares[key] = Square.new(Square::INITIAL_MARKER) }
  end

  def find_at_risk_space(line, marker)
    if count_marker(@squares.values_at(*line), marker) == 2        # if the line has 2 of the same markers
      line.each do |square|
        return square if get_square_at(square).marker == Square::INITIAL_MARKER          # if the line has a blank square, return that square
      end
    end
    nil
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
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end

  def mark
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  COMPUTER_NAMES = ['T1000', 'Shredder', 'Master P', 'Hal']
  INITIAL_MARKER = " "
  MARKERS = ["X", "O"]

  attr_reader :board, :human, :computer,:score, :current_player, :computer_name, :human_name

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = 'human'
    @score = {:human => 0, :computer => 0}
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

  def update_score(player)
    @score[player] += 1
  end

  def display_score
    puts "#{human_name}: #{score[:human]} - #{computer_name}: #{score[:computer]}"
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_board
    puts "You're #{human.marker}'s. Computer is #{computer.marker}'s."
    puts ""
    puts "First to win 5 rounds, wins."
    display_score
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
    choice = nil

    # offense
    Board::WINNING_LINES.each do |line|
     choice = board.find_at_risk_space(line, computer.marker) # check if computer is about to win
     break if choice
    end

    # defense
    if choice.nil?
      Board::WINNING_LINES.each do |line|
        choice = board.find_at_risk_space(line, human.marker) # check if computer is about to lose
        break if choice
      end
    end

    # middle square
    if choice.nil?
      if board.unmarked_keys.include?(5)
        choice = 5
      end
    end

    # Choose a random space.
    if choice.nil?
        choice = board.unmarked_keys.sample
    end
    
    board.set_square_at(choice, computer.marker)
  end

  def current_player_moves
    human_moves if human_turn?
    computer_moves if computer_turn?
    case current_player
    when 'human'
      set_current_player('computer')
    when 'computer'
      set_current_player('human')
    end
  end

  def human_turn?
    current_player == 'human'
  end

  def computer_turn?
    current_player == 'computer'
  end

  def choose_computer_name
    @computer_name = COMPUTER_NAMES.sample
  end

  def display_result
    case board.winning_marker
    when human.marker
      update_score(:human)
      puts "You won!"
    when computer.marker
      update_score(:computer)
      puts "Computer won!"
    else
      puts "It's a tie!"
    end

    current_player = ['human', 'computer']
    clear_screen_and_display_board
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

  def get_player_name
    name = nil
    loop do
      puts "What is your name?"
      name = gets.chomp
      if name.nil?
        puts "Sorry, that is not a valid input."
      else
        break
      end
    end

    @human_name = name
  end

  def get_player_marker
    marker = nil
    loop do
      puts "What marker do you want to use to mark your squares? (i.e. X's or O's)"
      marker = gets.chomp[0].capitalize
      if marker.nil?
        puts "Sorry, that is not a valid input."
      else
        break
      end
    end

    human.marker = marker
  end

  def who_plays_first?
    answer = nil
    loop do
      puts "Do you want to play first? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end

    if answer == 'y'
      set_current_player('human')
    else
      set_current_player('computer')
    end
  end

  def clear_screen
    system 'clear'
  end

  def set_current_player(player)
    @current_player = player
  end

  def reset
    board.reset
    clear_screen
    puts "Let's play again!"
    puts ""
    set_current_player('human')
  end

  def someone_won_5_rounds?
    score[:human] >= 5 || score[:computer] >= 5
  end

  public

  # Public Methods

  def play
    display_welcome_message
    clear_screen
    choose_computer_name
    get_player_name
    get_player_marker

    loop do
      who_plays_first?
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board # if human_turn?
      end
      display_result
      break if someone_won_5_rounds?
      break unless play_again? 
      reset
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play
