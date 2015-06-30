require 'hand.rb'
class Player
  attr_reader :pot, :hand
  def initialize(pot = 0,hand = nil)
    @pot = pot
    @hand = hand
    @folded = false
  end

  def bet_raise(current_bet,bet)
     if @pot < current_bet + bet
       raise "can't raise!"
     end
       @pot -= current_bet + bet
       current_bet + bet
  end

  def see(current_bet)
    if @pot < current_bet
      raise "can't bet!"
    end
    @pot -= current_bet
    current_bet
  end


  def discard(ref_card)
    @hand.hand.select! {|card| card != ref_card}
  end

  def fold
    @folded = true
  end

  def folded?
    @folded
  end

end
