class Card
  SUIT_NAMES = {
    :spade => "♠",
    :heart => "♥",
    :club => "♣",
    :diamond => "♦"
  }

  VALUES = {
    :ace => 14,
    :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    :ten => 10,
    :jack => 11,
    :queen => 12,
    :king => 13
  }

  def initialize(suit, value)
    check_validity(suit, value)
    @suit = suit
    @value = value
  end

  def value
    VALUES[@value]
  end

  def suit
    SUIT_NAMES[@suit]
  end

  def check_validity(suit, value)
    if !SUIT_NAMES.keys.include?(suit)
      raise "bad suit"
    elsif !VALUES.keys.include?(value)
      raise "bad value"
    end
  end

  def self.suits
    SUIT_NAMES.keys
  end

  def self.values
    VALUES.keys
  end
end
