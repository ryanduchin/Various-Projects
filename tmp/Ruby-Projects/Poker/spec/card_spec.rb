require 'rspec'
require 'card.rb'

describe Card do
  subject{Card.new(:heart, :four)}

  it "returns value" do
    expect(subject.value).to eq(4)
  end

  it "returns suit" do
    expect(subject.suit).to eq("♥")
  end

  it "raises error if bad suit" do
    expect{Card.new(:h, :four)}.to raise_error(RuntimeError, "bad suit")
  end

  it "raises error if bad value" do
    expect{Card.new(:heart, :f)}.to raise_error(RuntimeError, "bad value")
  end

end
