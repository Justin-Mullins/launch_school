# twenty_one.rb

def prompt(msg)
  puts "=> #{msg}"
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

system 'clear'
prompt 'Welcome to Twenty One'
prompt '----------------------'

# 1. Initialize deck
deck = initialize_deck

# 2. Deal cards to player and dealer
dealer_hand = deal_cards(deck)
prompt "Dealer has: #{dealer_hand[0]} and #{dealer_hand[1]}"

player_hand = deal_cards(deck)
prompt "Player has: #{player_hand[0]} and #{player_hand[1]}"

# 3. player turn: hit or stay
#  - repeat unil bust or stay

# 4.If player bust, dealer wins.

# 5. Dealer turn: hit or stay
# - repeat until total >= 17

# 6. If dealer bust, player wins.

# 7. Compare cards and declair winner.