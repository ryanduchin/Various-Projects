require 'rspec'
require 'deck.rb'

describe Deck do
  subject(:d) {Deck.new}
  subject(:d2) {Deck.new}

  it "Returns a 52 card deck" do
    expect(d.count).to eq(52)
  end

  #it "Returns a unique 52 card deck" do
  #  expeck(d.deck.uniq.count).to eq(52)
  #end

  it "shuffles the deck" do
    pre_shuffle = d.deck.dup
    d.shuffle
    expect(d.deck).not_to eq(pre_shuffle)
  end

  it "randomly initializes deck" do
    expect(d2.deck).not_to eq(d.deck)
  end

  it "draws cards from deck" do
    hand = d.draw(3)
    expect(hand.count).to eq(3)
    expect(d.count).to eq(49)
  end

  it "returns cards to the deck" do
    hand = d.draw(3)
    d.return_cards(hand)
    expect(d.count).to eq(52)
  end

  it "doesn't go over 52 cards" do
    single_card = d2.draw(1)
    expect{d.return_cards(single_card)}.to raise_error(RuntimeError,"only 52 cards allowed")
  end

  it "doesn't go less than 0 cards" do
    d.draw(52)
    expect(d.count).to eq(0)
    expect{d.draw(1)}.to raise_error(RuntimeError,
      "cannot draw from empty deck")
  end
end
