class Participant
  attr_accessor :hand, :name

  CARD_VALUES = { '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                  '7' => 7, '8' => 8, '9' => 9, '10' => 10,
                  'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => [1, 11] }

  def initialize(name)
    @name = name
    @hand = []
  end

  # Calculate the total value of a hand
  def calculate_total
    total = 0
    hand.each do |card|
      total += CARD_VALUES[card.rank.to_s] if card.rank != 'Ace'
    end
    aces = hand.count do |card|
      card.rank == 'Ace'
    end
    aces.times { total += (total + 11) > 21 ? 1 : 11 }
    total
  end

  def busted?
    calculate_total > 21
  end

  def show_cards
    puts "---- #{name}'s cards are: ----"
    hand.each { |card| puts "=> #{card}" }
    puts "=> Current total is #{calculate_total}"
    puts ""
  end
end

class Player < Participant
  def turn(deck)
    loop do
      choice = hit_or_stay?
      hand << deck.deal if choice == 'hit'
      show_cards if choice == 'hit'
      break if choice == 'stay' || busted?
    end
    puts "You chose to stay with a total of #{calculate_total}!" unless busted?
  end

  def hit_or_stay?
    loop do
      puts 'Do you want to hit or stay?'
      choice = gets.chomp.downcase
      return choice if %w(hit stay).include?(choice)
      puts "Sorry, that's not a valid choice."
    end
  end
end

class Dealer < Participant
  HIT_THRESHOLD = 17

  def turn(deck)
    sleep(1)
    hand << deck.deal unless calculate_total >= HIT_THRESHOLD
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @full_deck = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @full_deck << Card.new(rank, suit)
      end
    end
    @shuffled_deck = @full_deck.shuffle
  end

  def deal
    initialize if @shuffled_deck.empty?
    @shuffled_deck.pop
  end
end

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new("Player")
    @dealer = Dealer.new("Dealer")
    new_hand
  end

  def new_hand
    2.times { player.hand << deck.deal }
    2.times { dealer.hand << deck.deal }
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
    puts ""
  end

  def show_one_dealer_card
    puts "Dealer's cards are #{dealer.hand[0]} and ???"
    puts ""
  end

  def game_over?
    dealer_wins? || player.busted? || dealer.busted?
  end

  def dealer_wins?
    dealer.calculate_total > player.calculate_total &&
      dealer.calculate_total <= 21
  end

  def show_results
    if player.busted? || dealer.busted?
      show_busted
    elsif dealer_wins?
      puts "#{dealer.name} won with #{dealer.calculate_total} versus your #{player.calculate_total}."
    elsif player.calculate_total == dealer.calculate_total
      puts "It's a tie!"
    else
      puts "You win with #{player.calculate_total} to the dealer's #{dealer.calculate_total}!"
    end
  end

  def show_busted
    if player.busted?
      puts "It looks like #{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      "It looks like #{dealer.name} busted! #{player.name} wins!"
    end
  end

  def play
    display_welcome_message
    show_one_dealer_card
    player.show_cards
    player.turn(deck)
    loop do
      dealer.show_cards
      break if game_over? || dealer.calculate_total >= Dealer::HIT_THRESHOLD
      dealer.turn(deck)
    end
    show_results
  end
end

Game.new.play
