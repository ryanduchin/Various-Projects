require 'deck.rb'
class Hand
  attr_accessor :hand

  def initialize(cards)
    @hand = cards
  end

  def [](pos)
    @hand[pos]
  end

  def get_hand_score
    return 1 if straight_flush?
    return 2 if four_of_kind?
    return 3 if full_house?
    return 4 if flush?
    return 5 if straight?
    return 6 if three_of_kind?
    return 7 if two_pair?
    return 8 if pair?
    return 9
  end

  def winning_hand(hand_b)
    score_a = get_hand_score
    score_b = hand_b.get_hand_score
    case score_a<=>score_b
    when -1
      return self
    when 0
      return hand_b
    when 1
      return hand_b
    end
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_kind?
    get_same_cards.select{|k,v| v == 4}.count == 1
  end

  def full_house?
    get_same_cards.select{|k,v| v == 2}.count == 1 &&
    get_same_cards.select{|k,v| v == 3}.count == 1
  end

  def flush?
    ref_suit = hand.first.suit
    hand.all? do |card|
      card.suit == ref_suit
    end
  end

  def straight?
    values = []
    hand.each { |card| values << card.value }
    values.sort!
    check = values.map.with_index { |val, i| val - i }
    check.all? {|val| val == check.first }
  end

  def three_of_kind?
    get_same_cards.select{|k,v| v == 3}.count == 1
  end

  def two_pair?
    get_same_cards.select{|k,v| v == 2}.count == 2
  end

  def pair?
    get_same_cards.select{|k,v| v == 2}.count == 1
  end

  def high_card
    biggest_card = hand.first
    hand.each do |card|
      if card.value > biggest_card.value
        biggest_card = card
      end
    end
    biggest_card
  end

  def get_same_cards
    values = Hash.new {|h,k| h[k] = 0}
    @hand.each do |card|
       values[card.value] +=1
    end
    values
  end


end
