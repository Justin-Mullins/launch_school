# poker.rb
require 'pry'

module PokerRules
  VALUE_COMPARISON = { 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9,
    10 => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }

  def pair?
    hand_values.each do |card|
      return true if hand_values.count(card) == 2
    end
    false
  end

  def two_pair?
    temp_hand = hand_values.dup
    
    temp_hand.each do |card|
      if temp_hand.count(card) == 2
        temp_hand.delete(card)
        temp_hand.each do |other_card|
          return true if temp_hand.count(other_card) == 2
        end
      end
    end

    false
  end

  def three_of_kind?
    hand_values.each do |card|
      return true if hand_values.count(card) == 3
    end
    false
  end

  def straight?
    temp = hand_values.dup
    temp.map!{ |card| VALUE_COMPARISON[card] }.sort!
    
    return true if temp[0] == (temp[1] - 1) && temp[1] == (temp[2] - 1) && 
      temp[2] == (temp[3] - 1) && temp[3] == (temp[4] - 1)
    false
  end

  def flush?
    hand_suits.count(hand_suits[0]) == 5
  end

  def full_house?
    pair? && three_of_kind?
  end

  def four_of_kind?
    hand_values.each do |card|
      return true if hand_values.count(card) == 4
    end
    false
  end

  def straight_flush?
    straight? && flush?
  end
end

module Hand
  def display_hand
    card_index = 1

    puts "---- #{name}'s Hand ----"
    hand.each do |card|
      puts "=> [#{card_index}] #{card}"
      card_index += 1
    end
    puts ""
  end

  def add_card(new_card)
    hand << new_card
  end

  def discard(card_position)
    hand.delete_at(card_position)
  end

  def check_matches
    if straight_flush?
      return 'straight flush'
    elsif four_of_kind? 
      return 'four of a kind'
    elsif full_house?
      return 'a full house'
    elsif flush?
      return 'a flush'
    elsif straight?
      return 'a straight'
    elsif three_of_kind?
      return 'three of a kind'
    elsif two_pair?
      return 'two pair'
    elsif pair?
      return 'one pair'
    else
      return 'nothing'
    end
  end

  def get_score
    if straight_flush?
      return 8
    elsif four_of_kind? 
      return 7
    elsif full_house?
      return 6
    elsif flush?
      return 5
    elsif straight?
      return 4
    elsif three_of_kind?
      return 3
    elsif two_pair?
      return 2
    elsif pair?
      return 1
    else
      return 0
    end
  end

  def find_high_card
    if straight_flush? || straight? || flush?
      return Game::VALUE_COMPARISON.key(hand_values.map{ |card| Game::VALUE_COMPARISON[card] }.sort.last)
    elsif four_of_kind? 
      hand_values.each do |card|
        return card if hand_values.count(card) == 4
      end
    elsif three_of_kind? || full_house?
      hand_values.each do |card|
        return card if hand_values.count(card) == 3
      end
    elsif two_pair?
      card1 = nil
      card2 = nil

      hand_values.each do |card|
        card1 = card if hand_values.count(card) == 2 && !card1.nil?
        card2 = card if hand_values.count(card) == 2 && card1 != card
      end

      return card1 if Game::VALUE_COMPARISON[card1] > Game::VALUE_COMPARISON[card2]
      return card2
    elsif pair?
      hand_values.each do |card|
        return card if hand_values.count(card) == 2
      end
    end
  end
end

class Participant
  include Hand
  include PokerRules
  attr_accessor :name, :hand, :money

  def initialize
    @hand = []
    @money = 100
    set_name
  end

  def hand_values
    hand_values = []
    hand.each { |card| hand_values << card.value }
    hand_values
  end

  def hand_suits
    hand_suits = []
    hand.each { |card| hand_suits << card.suit }
    hand_suits
  end

  def reset
    @hand = []
  end
end

class Player < Participant
  def set_name
    name = 'Player'

    # loop do
    #   puts "What is your name?"
    #   name = gets.chomp
    #   break unless name.empty?
    #   puts "Sorry, you must enter a name."
    # end

    self.name = name
  end

  def display_hand
    super

    # puts "=> Money: $#{money}"
    # puts ""
    # puts ""
  end

end

class Dealer < Participant
  def set_name
    self.name = 'Computer'
  end

  def close_to_flush?
    suit_count = Hash.new 0
    hand_suits.each { |card| suit_count[card] += 1 }
    suit_count.values.sort.last >= 3
  end

  def discard_for_flush
    temp_hand = hand.dup
    temp_hand.each do |card|
      hand.delete(card) unless hand_suits.count(card.suit) >= 3
    end
  end

  def close_to_straight?
    temp = hand_values.dup
    temp.map!{ |card| VALUE_COMPARISON[card] }.sort!
    card1 = 0
    card2 = 1
    card_count = 0
    
    temp.each do |card|
      card_count += 1 if temp[card1] == (temp[card2] - 1)
      card1 += 1
      card2 += 1
      break if card1 == 4
    end

    card_count -= 1 if temp[0] == 2 || temp[4] == 14
    return true if card_count >= 3
    false
  end

  def discard_for_straight
    temp = hand.dup
    temp_values = hand_values.dup
    temp.sort! { |first, last|  VALUE_COMPARISON[first.value] <=> VALUE_COMPARISON[last.value] }
    temp_values.map!{ |card| VALUE_COMPARISON[card] }.sort!
    card1 = 0
    card2 = 1
    
    temp.each do |card|
      hand.delete(card) unless VALUE_COMPARISON[temp[card1].value] == (VALUE_COMPARISON[temp[card2].value] - 1)
      card1 += 1
      card2 += 1
      break if card1 == 4
    end
  end

  def discard_cards
    temp_hand = hand.dup

    case check_matches
    when 'nothing'
      if close_to_straight?
        discard_for_straight
      elsif close_to_flush?
        discard_for_flush
      else # if nothing else, only keep card with highest value
        high_card = hand_values.map{ |card| VALUE_COMPARISON[card] }.sort.last
        temp_hand.each do |card|
          hand.delete(card) unless card.value == VALUE_COMPARISON.key(high_card)
        end
      end
    when 'one pair'
      temp_hand.each do |card|
        hand.delete(card) unless hand_values.count(card.value) == 2
      end
    when 'two pair'
      temp_hand.each do |card|
        hand.delete(card) unless hand_values.count(card.value) == 2
      end
    when 'three of a kind'
      temp_hand.each do |card|
          hand.delete(card) unless hand_values.count(card.value) == 3
      end
    end
  end
end

class Deck
  attr_reader :cards
  SUITS = ["Hearts", "Spades", "Clubs", "Diamonds"]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUES.each { |value| @cards << Card.new(value, suit) }
    end

    shuffle
  end

  def deal(num_of_cards)
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

  def to_s
    "#{value} of #{suit}"
  end
end

class Game
  attr_reader :deck, :player, :dealer
  VALUE_COMPARISON = { 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9,
    10 => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def deal_initial_cards
    player.hand = deck.deal(5)
    dealer.hand = deck.deal(5)
  end

  def display_welcome_message
    puts "Welcome to Poker!"
  end

  def display_cards
    system "clear"
    puts " === Poker ==="
    puts ""
    player.display_hand
    dealer.display_hand
  end

  def player_choose_discards
    yes_or_no = nil
    card_to_discard = nil

    loop do
      card_index = 1
      card_indexes = []
      puts "Do you want to discard a card? (y/n)"
      yes_or_no = gets.chomp.downcase

      if yes_or_no == 'y'        
        puts "Which card do you want to discard?"
        loop do
          player.hand.each do
            card_indexes << card_index
            card_index += 1
          end
          puts "#{card_indexes.join(', ')}"
          card_to_discard = gets.chomp.to_i
          break if card_indexes.include?(card_to_discard)
          puts "Enter a valid choice."
        end
        sleep(0.75)
        player.discard(card_to_discard - 1)
        display_cards
        break if player.hand.length == 0
      end

      break if yes_or_no == 'n'
      puts "Sorry, must be y or n." unless %w(y n).include?(yes_or_no)
    end
  end

  def dealer_discards_cards
    # find cards to discard    
  end

  def player_turn
    player_choose_discards
    player.hand += deck.deal(5 - player.hand.length)
    display_cards
    sleep(0.75)
  end

  def dealer_turn
    combos = dealer.check_matches
    dealer.discard_cards
    display_cards
    sleep(0.75)
    dealer.hand += deck.deal(5 - dealer.hand.length)
    sleep(0.75)
    display_cards
  end

  def show_result
    if player.check_matches == 'nothing'
      player_high_card = player.hand_values.map{ |card| VALUE_COMPARISON[card] }.sort.last
    else
      player_high_card = VALUE_COMPARISON[player.find_high_card]
    end
    
    if dealer.check_matches == 'nothing'    
      dealer_high_card = dealer.hand_values.map{ |card| VALUE_COMPARISON[card] }.sort.last
    else
      dealer_high_card = VALUE_COMPARISON[dealer.find_high_card]
    end

    print_player_highest = "Player high card: #{VALUE_COMPARISON.key(player_high_card)}"
    print_dealer_highest = "Dealer high card: #{VALUE_COMPARISON.key(dealer_high_card)}"

    puts "You have #{player.check_matches}."
    sleep(0.75)
    puts "Dealer has #{dealer.check_matches}."
    puts ''
    puts "Player high card: #{VALUE_COMPARISON.key(player_high_card)}"
    puts "Dealer high card: #{VALUE_COMPARISON.key(dealer_high_card)}"
    puts ''

    if player.get_score > dealer.get_score
      puts 'You win!'
    elsif player.get_score < dealer.get_score
      puts 'Dealer wins!'
    else
      if player_high_card > dealer_high_card
        # puts print_player_highest
        # puts print_dealer_highest
        sleep(0.5)
        puts ""
        puts 'You win!'
      elsif player_high_card < dealer_high_card
        # puts print_player_highest
        # puts print_dealer_highest
        sleep(0.5)
        puts ""
        puts 'Dealer wins!'
      else
        puts "It's a tie!"
      end

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

  def reset_game
    sleep(1)
    @deck = Deck.new
    player.reset
    dealer.reset
  end

  def start
    display_welcome_message
    loop do
      # how_much_to_bet
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