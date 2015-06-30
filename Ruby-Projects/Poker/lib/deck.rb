require 'card.rb'
class Deck
attr_accessor :deck

  def initialize
    @deck = []
    seed_deck
  end

  def shuffle
    @deck.shuffle!
  end

  def count
    @deck.count
  end

  def seed_deck
    Card::suits.each do |suit|
      Card::values.each do |value|
        @deck << Card.new(suit, value)
      end
    end
    shuffle
  end

  def draw(num)
    cards = []
    if @deck.count >= num
      num.times do
        cards << @deck.pop
      end
    else
      raise "cannot draw from empty deck"
    end
    cards
  end

  def return_cards(cards)
    if cards.count + deck.count <=52
      @deck = cards + @deck
    else
      raise "only 52 cards allowed"
    end
  end

end
