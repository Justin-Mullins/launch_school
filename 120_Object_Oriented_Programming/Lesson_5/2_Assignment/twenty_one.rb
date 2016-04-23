# twenty_one.rb

module Hand
  def display_hand
    puts "---- #{name}'s Hand ----"
    hand_values.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total_hand_value}"
    puts ""
  end

  def busted?
    total_hand_value > 21
  end

  def total_hand_value
    total = 0
    num_of_aces = hand_values.count('Ace')

    hand_values.each do |card|
      if card == 'Jack' || card == 'Queen' || card == 'King'
        total += 10
      elsif card == 'Ace'
        total += 11
      else
        total += card
      end
      # Correct values for Aces
      if total > 21 && num_of_aces > 0
        num_of_aces -= 1
        total -= 10
      end
    end
    return total
  end

  def add_card(new_card)
    hand << new_card
  end
end

class Participant
  include Hand
  attr_accessor :name, :hand

  def initialize
    @hand = []
    set_name
  end

  def hand_values
    hand_values = []
    hand.each { |card| hand_values << card.value }
    hand_values
  end

  def reset
    @hand = []
  end
end

class Player < Participant
  def set_name
    name = ''

    loop do
      puts "What is your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, you must enter a name."
    end

    self.name = name
  end
end

class Dealer < Participant
  def set_name
    self.name = 'Computer'
  end

  def display_hand
    temp_hand = hand_values
    temp_hand[0] = 'unknown'

    puts "---- #{name}'s Hand ----"
    temp_hand.each do |card|
      puts "=> #{card}"
    end
    puts ""
  end
end

class Deck
  attr_reader :cards
  SUITS = ["hearts", "spades", "clubs", "diamonds"]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUES.each { |value| @cards << Card.new(value, suit) }
    end

    shuffle
  end

  def deal(num_of_cards)
    return cards.pop if num_of_cards == 1
    cards.pop(num_of_cards)
  end

  def shuffle
    cards.shuffle!
  end
end

class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @suit = suit
    @value = value
  end
end

class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def deal_initial_cards
    player.hand = deck.deal(2)
    dealer.hand = deck.deal(2)
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end

  def display_cards
    system "clear"
    puts " === Twenty-One ==="
    puts ""
    player.display_hand
    dealer.display_hand
  end

  def hit_or_stay?
    answer = nil
    loop do
      puts "Hit or stay? (h/s)"
      answer = gets.chomp.downcase # get user input
      break if %w(h s).include? answer # break if 'h' or 's'
      puts "Sorry, must be h or s."
    end
    answer
  end

  def player_turn
    while !player.busted?
      if hit_or_stay? == 'h'
        player.add_card(deck.deal(1))
        display_cards
        puts "Player bust!" if player.busted?
      else
        break # if stay, break
      end
    end
  end

  def dealer_turn
    while dealer.total_hand_value < 21 && dealer.total_hand_value <= player.total_hand_value && !player.busted?
      sleep(0.5)
      dealer.add_card(deck.deal(1))
      display_cards
      puts "Dealer bust!" if dealer.busted?
    end
  end

  def show_result
    puts "=> Dealer Total: #{dealer.total_hand_value}"
    if dealer.total_hand_value > player.total_hand_value && !dealer.busted?
      puts "You Lose!"
    elsif player.total_hand_value > dealer.total_hand_value && !player.busted?
      puts "You Win!"
    elsif (!dealer.busted? && !player.busted?) || player.total_hand_value == dealer.total_hand_value
      puts "It's a Tie."
    end
    puts ""
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

  def reset_game
    sleep(1)
    @deck = Deck.new
    player.reset
    dealer.reset
  end

  def start
    display_welcome_message
    loop do
      deal_initial_cards
      display_cards
      player_turn
      dealer_turn
      show_result
      break unless play_again?
      reset_game
    end
  end
end

Game.new.start
