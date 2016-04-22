# twenty-one.rb
require 'pry'

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
    return true if total_hand_value > 21
    false
  end

  def total_hand_value
    total = 0
    num_of_aces = hand_values.count('Ace')

    hand_values.each do |card| # go though each card in hand
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
    cards << new_card
  end
end

class Participant
  include Hand

  attr_accessor :name, :hand, :hand_values
  def initialize
    @hand = []
    @hand_values = []
    set_name
  end

  def set_hand_values
    hand.each { |card| hand_values << card.value }
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
end

class Deck
  attr_reader :cards
  SUITS = ["hearts", "spades", "clubs", "diamonds"]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUES.each { |value| @cards << Card.new(value, suit) } # generate deck of Card objects
    end

    shuffle
  end

  def deal(num_of_cards)
    @cards.pop(num_of_cards)
  end

  def shuffle
    @cards.shuffle!
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
    player.hand = deck.deal(2) # deal each player 2 initial cards
    dealer.hand = deck.deal(2)
  end

  def display_initial_cards
    system "clear"
    puts "Welcome to Twenty-One!"
    puts ""
    player.set_hand_values
    player.display_hand
    # add starting cards' values to hand_values
    dealer.hand.each { |card| dealer.hand_values << card.value }
    dealer.display_hand
    puts ""
  end

  def display_cards
    system "clear"
    puts "Twenty-One"
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
    while player.busted? == false
      if hit_or_stay? == 'h' # if hit
        player.hand.concat(deck.deal(1)) # deal 1 more card (object) to player (hand)
        player.hand_values << player.hand.last.value # add the value of that card to hand_values
        display_cards
        puts "Player bust!" if player.busted?
      else
        break # if stay, break
      end 
    end
  end

  def dealer_turn
    while dealer.total_hand_value < 21 && dealer.total_hand_value <= player.total_hand_value && player.busted? == false
      sleep(0.5)
      dealer.hand.concat(deck.deal(1)) # deal 1 more card (object) to dealer (hand)
      dealer.hand_values << dealer.hand.last.value # add the value of that card to hand_values
      display_cards
      puts "Dealer bust!" if dealer.busted?
    end
  end

  def show_result
    if dealer.total_hand_value > player.total_hand_value && !dealer.busted?
      puts "You Lose!"
    elsif player.total_hand_value > dealer.total_hand_value && !player.busted?
      puts "You Win!"
    elsif (dealer.busted? && player.busted?) || player.total_hand_value == dealer.total_hand_value
      puts "It's a Tie."
    end
    puts ""
  end

  def start
    deal_initial_cards
    display_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start