require 'player'

RSpec.describe Player do
  describe '#initialize' do
    it "requires arguments" do
      expect { Player.new }.to raise_error(ArgumentError)
    end

    it "initialize with valid arguments" do
      expect { Player.new("John", "X") }.to_not raise_error
    end

    it "expects 2 arguments" do
      expect { Player.new("John") }.to raise_error(ArgumentError)
    end
  end

  let(:player) do
    @player = Player.new("John", "X")
  end

  describe "#name" do
    it "returns the name" do
      expect(player.name).to eql("John")
    end
  end

  describe "#mark" do
    it "returns the mark" do
      expect(player.mark).to eql("X")
    end

    it "works with unicode" do
      player1 = Player.new("Sleepy", "\u25EF")
      expect(player1.mark).to eql("◯")
    end
  end
end