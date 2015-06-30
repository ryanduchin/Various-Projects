require 'rspec'
require 'hand.rb'

describe Hand do

  let(:card_one) {Card.new(:spade, :two)}
  let(:card_two) {Card.new(:spade, :three)}
  let(:card_three) {Card.new(:heart, :four)}
  let(:card_four) {Card.new(:heart, :ace)}
  let(:card_five) {Card.new(:club, :two)}
  let(:card_six) {Card.new(:club, :king)}
  let(:card_seven) {Card.new(:club, :ace)}
  let(:card_eight) {Card.new(:heart, :two)}
  let(:card_nine) {Card.new(:spade, :jack)}
  let(:card_ten) {Card.new(:spade, :queen)}
  let(:card_eleven) {Card.new(:heart, :ten)}
  let(:card_twelve) {Card.new(:club, :nine)}
  let(:card_thirteen) {Card.new(:club, :eight)}
  let(:card_aa) {Card.new(:spade, :four)}
  let(:card_ab) {Card.new(:spade, :ace)}
  let(:card_ac) {Card.new(:club, :eight)}
  let(:card_ad) {Card.new(:club, :three)}
  let(:card_ae) {Card.new(:diamond, :two)}
  let(:card_af) {Card.new(:spade, :ten)}
  let(:card_ag) {Card.new(:spade, :nine)}
  let(:card_ah) {Card.new(:spade, :eight)}

  let(:bad_hand) {Hand.new([card_two, card_three, card_one, card_four, card_six])}
  let(:worse_bad_hand) {Hand.new([card_two, card_three, card_one, card_nine, card_six])}
  let(:one_pair_hand) {Hand.new([card_one, card_two, card_three, card_four, card_five])}
  let(:two_pair_hand) {Hand.new([card_one, card_two, card_four, card_seven, card_five])}
  let(:worse_two_pair_hand) {Hand.new([card_one, card_two, card_ad, card_seven, card_five])}
  let(:three_kind_hand) {Hand.new([card_one, card_two, card_four, card_eight, card_five])}
  let(:straight_hand) {Hand.new([card_nine, card_ten, card_eleven, card_twelve, card_thirteen])}
  let(:flush_hand) {Hand.new([card_one, card_two, card_aa, card_ab, card_af])}
  let(:full_house_hand) {Hand.new([card_one, card_two, card_eight, card_ad, card_five])}
  let(:four_kind_hand) {Hand.new([card_one, card_two, card_eight, card_ae, card_five])}
  let(:straight_flush_hand) {Hand.new([card_nine, card_ten, card_af, card_ag, card_ah])}
  let(:better_one_pair_hand) {Hand.new([card_one, card_two, card_three, card_four, card_seven])}

  #in future only need public tests

  describe "#pair" do

    it "should return true when pair" do
      expect(one_pair_hand.pair?).to eq(true)
    end

    it "should return false when no pair" do
      expect(bad_hand.pair?).to eq(false)
    end
  end

  describe "#two_pair?" do

    it "should return true" do
      expect(two_pair_hand.two_pair?).to eq(true)
    end

    it "should return false" do
      expect(one_pair_hand.two_pair?).to eq(false)
    end
  end

  describe "#three_of_kind?" do
    it "should return true" do
      expect(three_kind_hand.three_of_kind?).to eq(true)
    end

    it "should return false" do
      expect(straight_hand.three_of_kind?).to eq(false)
    end
  end

  describe "#straight?" do
    it "should return true" do
      expect(straight_hand.straight?).to eq(true)
    end

    it "should return false" do
      expect(flush_hand.straight?).to eq(false)
    end
  end

  describe "#flush?" do
    it "should return true" do
      expect(flush_hand.flush?).to eq(true)
    end

    it "should return false" do
      expect(straight_hand.flush?).to eq(false)
    end
  end

  describe "full_house?" do
    it "should return true" do
      expect(full_house_hand.full_house?).to eq(true)
    end

    it "should return false" do
      expect(three_kind_hand.full_house?).to eq(false)
    end
  end

  describe "four_of_kind?" do
    it "should return true" do
      expect(four_kind_hand.four_of_kind?).to eq(true)
    end

    it "should return false" do
      expect(full_house_hand.four_of_kind?).to eq(false)
    end
  end

  describe "straight_flush?" do
    it "should return true" do
      expect(straight_flush_hand.straight_flush?).to eq(true)
    end

    it "should return false for straight" do
      expect(straight_hand.straight_flush?).to eq(false)
    end

    it "should return false for flush" do
      expect(flush_hand.straight_flush?).to eq(false)
    end
  end

  describe "high_card" do
    it "returns highest card" do
      expect(bad_hand.high_card).to eq(card_four)
    end
  end

  describe "#winning_hand" do
    it "straight_flush beats four_of_kind" do
      expect(straight_flush_hand.winning_hand(four_kind_hand)).to eq(straight_flush_hand)
    end

    it "four_of_kind beats below" do
      expect(full_house_hand.winning_hand(four_kind_hand)).to eq(four_kind_hand)
    end

    it "full_house beats below" do
      expect(full_house_hand.winning_hand(flush_hand)).to eq(full_house_hand)
    end

    it "flush beats below" do
      expect(straight_hand.winning_hand(flush_hand)).to eq(flush_hand)
    end

    it "straight beats below" do
      expect(straight_hand.winning_hand(three_kind_hand)).to eq(straight_hand)
    end

    it "three of kind beats below" do
      expect(three_kind_hand.winning_hand(two_pair_hand)).to eq(three_kind_hand)
    end

    it "two pair beats pair" do
      expect(one_pair_hand.winning_hand(two_pair_hand)).to eq(two_pair_hand)
    end

    it "pair beats no hand" do
      expect(one_pair_hand.winning_hand(bad_hand)).to eq(one_pair_hand)
    end

    it "highest card wins if no hands" do
      expect(bad_hand.winning_hand(worse_bad_hand)).to eq(bad_hand)
    end

    it "highest card wins if same hands" do
      expect(two_pair_hand.winning_hand(worse_two_pair_hand)).to eq(two_pair_hand)
    end

    it "returns better hand if not direct comparison" do
      expect(two_pair_hand.winning_hand(four_kind_hand)).to eq(four_kind_hand)
    end
  end

end
