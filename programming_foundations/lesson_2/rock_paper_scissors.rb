# rock_paper_scissors.rb

require 'pry'

PLAYER = "player"
COMPUTER = "computer"
VALID_CHOICES = { 1 => "rock", 2 => "paper", 3 => "scissors", 4 => "lizard", 5 => "spock" }
WIN_CONDITIONS = { "rock" => %w(scissors lizard), "paper" => %w(rock spock), "scissors" => %w(paper lizard), "spock" => %w(rock scissors), "lizard" => %w(paper spock) }

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  WIN_CONDITIONS[first][0] == second || WIN_CONDITIONS[first][1] == second
end

def who_won?(player, computer)
  if win?(player, computer)
    PLAYER
  elsif win?(computer, player)
    COMPUTER
  else
    "tie"
  end
end

def add_win(winner, win_count)
  if winner == COMPUTER
    win_count[COMPUTER] += 1
  elsif winner == PLAYER
    win_count[PLAYER] += 1
  end
  return win_count
end

def check_win_count(win_count)
  win_count[COMPUTER] >= 5 || win_count[PLAYER] >= 5
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

win_count = { "player" => 0, "computer" => 0 }

prompt("First to 5 wins")
# Main Loop
loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.values}")
    prompt("Enter 1 for rock; 2 for paper; 3 for scissors; 4 for lizard; 5 for spock")
    choice = gets.chomp.to_i

    if VALID_CHOICES.keys.include?(choice)
      choice = VALID_CHOICES[choice]
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.values.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)
  winner = who_won?(choice, computer_choice)
  win_count = add_win(winner, win_count)

  prompt("Total wins: Computer - #{win_count[COMPUTER]}  Player - #{win_count[PLAYER]}")

  if check_win_count(win_count)
    break
  end

  puts ""

  # prompt("Do you want to play again?")
  # answer = gets.chomp
  # break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good Bye!")
