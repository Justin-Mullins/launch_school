class Player
  def initialize
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

class Dealer
  def initialize
    # seems like very similar to Player... do we even need this?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Deck
  def initialize
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?
    @suit = ["hearts", "spades", "clubs", "diamonds"]
    @cards = []
    suits.each do |suit|
      (1..10).each { |value| @cards << Card.new(value, suit) }
    end
  end

  def deal(num_of_cards)

  end
end

class Card
  def initialize(value, suit)
    # what are the "states" of a card?
    @suit = suit
    @value = value
  end
end

class Game

  def initialize
    @deck = Deck.new
  end

  def start
    # what's the sequence of steps to execute the game play?
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end
  end
end

Game.new.start