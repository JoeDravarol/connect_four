require 'player'
require 'board'

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

  let(:board) do
    @board = Board.new
  end

  describe "#drop_mark" do
    it "drops mark on the bottom of empty column" do
      player.drop_mark(0, board)
      expect(board.square[0][5]).to eql("X")
    end

    it "drops mark on top of another mark" do
      player.drop_mark(1, board)
      player.drop_mark(1, board)
      expect(board.square[1][4]).to eql("X")
    end

    context "returns error message" do
      it "when drop mark on a column that is full" do
        # Fill all the columns
        6.times { player.drop_mark(2, board) }
  
        expect(player.drop_mark(2, board)).to eql "Invalid drop"
      end

      it "when drop mark on non-existing column" do
        expect(player.drop_mark(7, board)).to eql "Invalid drop"
      end
    end
  end
end