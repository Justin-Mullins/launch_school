# tictactoe.rb

require 'pry'

PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
INITIAL_MARKER = ' '
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(array, separator=', ', final_separator='or')
  string = ''
  if array.length <= 1
    return array.join
  elsif array.length > 2
    string = array.first(array.length - 2).join("#{separator}") +
             "#{separator}"
  end  
  string += array.last(2).join(" #{final_separator} ")
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "Player is X's. Computer is O's."
  puts ''
  puts '     |     |  '
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |  '
  puts '-----------------'
  puts '     |     |  '
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |  '
  puts '-----------------'
  puts '     |     |  '
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |  '
  puts ''
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  board = {}
  (1..9).each { |position| board[position] = INITIAL_MARKER }
  board
end

def blank_spaces(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_move!(brd)
  choice = ''
  loop do
    prompt "Choose a position to place a piece:"
    prompt "#{joinor(blank_spaces(brd))}"
    choice = gets.chomp.to_i
    break if blank_spaces(brd).include?(choice)
    prompt 'Not a valid choice.'
  end

  brd[choice] = PLAYER_MARKER
end

def computer_move!(brd)
  space = nil

  # offense
  WINNING_LINES.each do |line|
   space = find_at_risk_space(line, brd, COMPUTER_MARKER) # check if computer is about to win
   break if space
  end

  # defense
  if !space
    WINNING_LINES.each do |line|
      space = find_at_risk_space(line, brd, PLAYER_MARKER) # check if computer is about to lose
      break if space
    end
  end

  # middle square
  if !space
    if brd[5] == INITIAL_MARKER
      space = 5
    end
  end

  # random space
  if !space # if space is not nil
    space = blank_spaces(brd).sample
  end
  
  brd[space] = COMPUTER_MARKER
end

def board_full?(brd)
  blank_spaces(brd) == []
end

def winner_is(brd)
  WINNING_LINES.each do |line|
    values = brd.values_at(line[0], line[1], line[2])
    if values.count('X') == 3
      return 'Player'
    elsif values.count('O') == 3
      return 'Computer'
    end
  end
  nil
end

def game_won?(brd)
  !winner_is(brd).nil?
end

def win_count(winner, score)
  score[winner] += 1
end

def display_score(score)
  prompt "------------------------------------"
  prompt "First to a score of 5, wins."
  prompt "------------------------------------"
  prompt "Score: Player - #{score['Player']}, " +
         "Computer - #{score['Computer']}"
  prompt "------------------------------------"
end

def find_at_risk_space(line, board, marker)
  if board.values_at(*line).count(marker) == 2 # if line has 2 markers (X's or O's)
    board.select{|key,value| line.include?(key) && value == INITIAL_MARKER}.keys.first # selects pos on board in line equal to ' '. returns key value of that pos
  else
    nil
  end
end

def choose_first_player
  prompt "Choose who will play first.('c' for Computer or 'p' for Player)"
  loop do
    player = gets.chomp
    if player.downcase.start_with?('c')
      return 'Computer'
    elsif player.downcase.start_with?('p')
      return 'Player'
    else
      prompt "Invalid choice."
    end
  end
end

def alternate_player(current_player)
  if current_player == 'Player'
    return 'Computer'
  else
    return 'Player'
  end
end

def place_piece!(board, current_player)
  if current_player == 'Player'
    player_move!(board)
  else
    computer_move!(board)
  end
end

system 'clear'
prompt 'Welcome to Tic-Tac-Toe.'

score = {'Player' => 0, 'Computer' => 0}
display_score(score)

loop do # main loop
  current_player = choose_first_player
  
  board = initialize_board

  loop do # turns loop
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if game_won?(board) || board_full?(board)
  end

  display_board(board)

  if game_won?(board) 
    prompt "#{winner_is(board)} won!" # display winner
    win_count(winner_is(board), score) # add win to score
  else
    prompt "It's a tie!"
  end

  display_score(score)
  
  if score['Player'] >= 5 || score['Computer'] >= 5 # if score is 5, game ends
    sleep(2)
    break
  end

  prompt 'Play again? (y or n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt 'Thanks for playing.'
