# twenty_one.rb

CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'jack' => 10,
                'queen' => 10, 'king' => 10, 'ace' => 11 }

def prompt(msg)
  puts "=> #{msg}"
end

def display_hands(dealer_hand, player_hand, hide_dealer_card)
  system 'clear'
  new_dealer_hand = dealer_hand.dup

  if hide_dealer_card == true # hide one of the dealer's cards
    new_dealer_hand[1] = 'unknown card'
  end

  prompt 'Twenty One'
  prompt '-----------'
  prompt 'Dealer has: ' + joinor(new_dealer_hand, ', ', 'and')
  prompt 'Player has: ' + joinor(player_hand, ', ', 'and')
end

def joinor(array, separator = ', ', final_separator = 'or')
  string = ''
  if array.length <= 1
    return array.join
  elsif array.length > 2
    string = array.first(array.length - 2).join("#{separator}") +
             "#{separator}"
  end
  string + array.last(2).join(" #{final_separator} ")
end

# create deck and shuffle
def initialize_deck
  deck = []
  4.times do
    deck += ('2'..'10').to_a + %w(jack queen king ace)
  end
  deck.shuffle!
end

def deal_cards(deck)
  deck.pop(2)
end

def player_turn(deck, player_hand)
  prompt "Do you want to Hit or Stay?('h' or 's')"
  choice = gets.chomp

  # hit
  if choice.downcase.start_with?('h')
    hit(deck, player_hand)
  # stay
  elsif choice.downcase.start_with?('s')
    return 's'
  else
    prompt "That's not a valid choice."
    player_turn(deck, player_hand)
  end
end

def hit(deck, player_hand)
  player_hand << deck.pop
end

def bust(hand)
  get_score(hand) > 21
end

def get_score(hand)
  score = 0
  hand.each do |card|
    score += CARD_VALUES[card]
  end

  hand.count('ace').times do # adjust score for aces if total over 21
    if score > 21
      score -= 10
    end
  end
  score
end

def who_won?(player_total, dealer_total)
  if dealer_total > player_total && dealer_total <= 21
    return 'Dealer'
  elsif player_total > dealer_total && player_total <= 21
    return 'Player'
  elsif dealer_total > 21
    return 'Player'
  elsif player_total > 21
    return 'Dealer'
  else
    return 'Tie'
  end
end

loop do # first to five wins
  score  = { 'Player' => 0, 'Dealer' => 0 }

  loop do # main loop
    # 1. Initialize deck
    deck = initialize_deck
    hide_dealer_card = true

    # 2. Deal cards to player and dealer
    dealer_hand = deal_cards(deck)
    player_hand = deal_cards(deck)

    display_hands(dealer_hand, player_hand, hide_dealer_card)

    # 3. player turn: hit or stay
    #  - repeat until bust or stay
    stay = false
    player_bust = false

    # player turn loop
    loop do
      stay = player_turn(deck, player_hand)
      break if stay == 's' || bust(player_hand)
      display_hands(dealer_hand, player_hand, hide_dealer_card)
    end

    player_total = get_score(player_hand)

    # 4.If player bust, dealer wins.
    if bust(player_hand)
      prompt "Your score is #{player_total}. You bust!"
      player_bust = true
    end

    hide_dealer_card = false
    display_hands(dealer_hand, player_hand, hide_dealer_card)

    # 5. Dealer turn: hit or stay
    # - repeat until total >= 17

    if player_bust == false
      loop do # dealer turn loop
        break if get_score(dealer_hand) >= 17
        sleep 0.8
        hit(deck, dealer_hand)
        display_hands(dealer_hand, player_hand, hide_dealer_card)
      end
    end

    dealer_total = get_score(dealer_hand)

    # 6. If dealer bust, player wins.
    if bust(dealer_hand) == true
      prompt "Dealer's total is #{dealer_total}. Dealer bust!"
    end

    # 7. Compare cards and declair winner.
    winner = who_won?(player_total, dealer_total)
    if winner == 'Player' || winner == 'Dealer'
      prompt "#{winner} wins!"

      prompt "Player total: #{get_score(player_hand)}, " \
        "Dealer total: #{get_score(dealer_hand)}"

      score[winner] += 1
    else
      prompt "It's a tie!"
    end

    prompt '------------------------------------------'
    prompt 'First to 5, wins.'
    prompt "Score: Player => #{score['Player']}, Dealer => #{score['Dealer']}"
    break if score['Player'] == 5 || score['Dealer'] == 5

    # Play again?
    prompt 'Play again? (y or n)'
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
  break if score['Player'] == 5 || score['Dealer'] == 5
  break unless answer.downcase.start_with?('y')
end

prompt 'Thanks for playing.'
