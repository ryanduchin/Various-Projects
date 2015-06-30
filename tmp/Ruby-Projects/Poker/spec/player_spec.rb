require 'rspec'
require 'player.rb'
require 'deck.rb'
describe Player do

  let(:card_one) {Card.new(:spade, :two)}
  let(:card_two) {Card.new(:spade, :three)}
  let(:card_three) {Card.new(:heart, :four)}
  let(:card_four) {Card.new(:heart, :ace)}
  let(:card_five) {Card.new(:club, :two)}
  let(:card_six) {Card.new(:club, :king)}

  let(:hand) {Hand.new([card_two, card_three, card_one, card_four, card_six])}

  subject(:player) {Player.new(500,hand)}

  describe "#raise" do
    current_bet = 200
    it "raises the bet" do
      new_bet = player.bet_raise(current_bet,100)
      expect(player.pot).to eq(200)
      expect(new_bet).to eq(300)
    end

    it "doesn't exceed pot" do
      expect{player.bet_raise(current_bet, 301)}.to raise_error("can't raise!")
    end

  end

  describe "#see" do
    it "#sees the bet" do
      current_bet = 200
      player.see(current_bet)
      expect(player.pot).to eq(300)
    end

    it "doesn't exceeed pot" do
      current_bet = 600
      expect{player.see(current_bet)}.to raise_error("can't bet!")
    end
  end

  describe "#fold" do
    it "changes fold value" do
      player.fold
      expect(player.folded?).to eq(true)
    end
  end

  describe "#discard" do
    let(:reduced_hand) {Hand.new([card_three, card_one, card_four, card_six])}
    it "removes card from hand" do
      reduced_cards = reduced_hand.hand
      player.discard(card_two)
      expect(player.hand.hand).to eq(reduced_cards)
    end
  end



end
