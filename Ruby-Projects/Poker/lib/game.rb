require 'player.rb'
class Game
  def initialize(player1, player2)
    @deck = Deck.new
    @players = players
    @current_player = player1
    @pot = 0
  end

  def start_game
    until over?
      deal
      betting_round
      discard_round
      deal
      betting_round
      winner = determine_winner
      winner.pot += pot
      pot = 0
      reset_hands
    end
  end

  def deal
    @players.each do |player|
      next if player.folded?
      num = 5 - player.hand.count
      player.hand.hand << deck.draw(num)
    end
  end

  def betting_round
    until see_num == @players.count - 1
      #looping index through all players
        player.bet #no method here to prompt player to choose raise or see
        if player.raised?
          see_num = 0
        elsif player.see?
          see_num += 1
        end
    end

  end

  def discard_round
    @players.each do |player|
      player.discard #player needs to choose cards...
    end
  end

  def reset_hands
    @players.each { |player| player.hand = nil } #hand.hand??
  end

  def over?
  end
end
