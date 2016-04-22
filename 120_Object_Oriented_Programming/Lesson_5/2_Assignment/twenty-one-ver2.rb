# twenty-one.rb
require 'pry'

class Participant
  # :hand is the Card objects in hand
  # :hand are the actual values of the cards
  attr_accessor :hand, :hand

  def initialize
    @hand = []
  end

  def display_hand
    puts hand.join(',')
  end

  def busted?
    return true if total_hand_value > 21
    false
  end

  def total_hand_value
    total = 0
    # I needed to get the all of the aces to the end of the array to easily
    # count their values. This block of code below is a sloppy attempt at
    # that. 
    temp_hand = hand.dup # create dup of hand
    if temp_hand.include?('Ace') # if hand includes 'Ace'
      num_of_aces = temp_hand.count('Ace') # store num_of_aces
      temp_hand.delete('Ace') # delete all 'Ace's from hand
      num_of_aces.times { temp_hand.push('Ace') } # add num of aces to end of hand
    end

    # OK, now that I have all of the Aces at the end of the array,
    # it's easy to total.
    temp_hand.each do |card| # go though each card in hand
      card_value = card
      card_value = 10 if card == 'Jack' || card == 'Queen' || card == 'King'
      if card == 'Ace'
        if (total + 11) > 21
          card_value = 1
        else
          card_value = 11
        end
      end
      total += card_value
    end
    return total
  end
end

class Player < Participant
  def initialize
    super
    #  what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def hit
  
  end

  def stay

  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Dealer < Participant
  def initialize
    super
  end

  def hit
  end

  def stay
  end

  def total
  end

  def display_hand
    puts hand.join(',')
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

  def to_s
    @value
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
    puts ""
    puts "Player:"
    # add starting cards' values to hand
    player.hand.map! { |card| card.value }
    player.display_hand
    puts "total: #{player.total_hand_value}"
    puts ""
    puts "Dealer:"
    # convert hand from card objects to just the actual card values
    # this will make operating on the cards/hand easier since suit
    # is unnecessary in this game.
    dealer.hand.map! { |card| card.value }
    dealer.display_hand
    puts "total: #{dealer.total_hand_value}"
    puts ""
  end

  def display_cards
    system "clear"
    puts ""
    puts "Player:"
    player.display_hand
    puts "total: #{player.total_hand_value}"
    puts ""
    puts "Dealer:"
    dealer.display_hand
    puts "total: #{dealer.total_hand_value}"
    puts ""
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
        player.hand << player.hand.last.value # add the value of that card to hand
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
      dealer.hand << dealer.hand.last.value # add the value of that card to hand
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

  def welcome_message
    "Hello, Welcome to Blackjack!"
    sleep(1.5)
  end

  def start
    welcome_message
    deck.shuffle
    deal_initial_cards
    display_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start