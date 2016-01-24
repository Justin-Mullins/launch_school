# twenty_one.rb

def prompt(msg)
  puts "=> #{msg}"
end

def display_hands(dealer_hand, player_hand)
  system 'clear'

  prompt 'Twenty One'
  prompt '-----------'
  prompt "Dealer has: " + joinor(dealer_hand, ', ', 'and')
  prompt "Player has: " + joinor(player_hand, ', ', 'and')
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

# create deck and shuffle 
def initialize_deck
  deck = []
  4.times do 
    deck += ('2'..'9').to_a
    deck += ['jack', 'queen', 'king', 'ace']
  end
  deck.shuffle! 
end

def deal_cards(deck)
  cards = deck.pop(2)
end

def player_turn(deck, player_hand)
  prompt "Do you want to Hit or Stay?('h' or 's')"
  choice = gets.chomp

  # hit
  if choice.downcase.start_with?('h')
    hit(deck, player_hand)
  # stay
  elsif choice.downcase.start_with?('s')
    's'
  else
    prompt "That's not a valid choice."
    player_turn(deck, player_hand)
  end
end

def hit(deck, player_hand)
  player_hand << deck.pop
end

def bust(hand)
  score = get_score(hand)

  if score > 21
    return true
  end
  false
end

def get_score(hand)
  score = 0
  hand.each do |card|
    if card == 'jack' || card == 'queen' || card == 'king'
      score += 10
    elsif card == 'ace'
      if score > 21
        score += 1
      else
        score += 11
      end  
    else
      score += card.to_i
    end
  end
  score
end

loop do 

  loop do 

    # 1. Initialize deck
    deck = initialize_deck

    # 2. Deal cards to player and dealer
    dealer_hand = deal_cards(deck)
    player_hand = deal_cards(deck)

    display_hands(dealer_hand, player_hand)

    # 3. player turn: hit or stay
    #  - repeat until bust or stay
    stay = false
    loop do
      stay = player_turn(deck, player_hand)
      break if stay == 's' || bust(player_hand)
      display_hands(dealer_hand, player_hand)
    end

    # 4.If player bust, dealer wins.
    if bust(player_hand)
      display_hands(dealer_hand, player_hand)
      prompt "Your total is #{get_score(player_hand)}. You bust!"
      break
    end

    # 5. Dealer turn: hit or stay
    # - repeat until total >= 17

    # 6. If dealer bust, player wins.

    # 7. Compare cards and declair winner.
    prompt "#{who_won?(player_hand, dealer_hand)} won!"
  end
  prompt 'Do you want to play again?'
end

