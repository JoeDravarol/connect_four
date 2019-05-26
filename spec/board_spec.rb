require 'board'

RSpec.describe Board do
  let(:board) do
    @board = Board.new
  end

  describe "#initialize" do
    it "creates a 7 column square" do
      expect(board.square.length).to eql(7)
    end

    it "creates a 6 row squares" do
      board.square.each do |row|
        expect(row.length).to eql(6)
      end
    end
  end

  describe "#drop_mark" do
    it "drops mark on the bottom of empty column" do
      board.drop_mark(0, "X")
      expect(board.square[0][5]).to eql("X")
    end

    it "drops mark on top of another mark" do
      board.drop_mark(0, "X")
      board.drop_mark(0, "O")
      expect(board.square[0][4]).to eql("O")
    end

    context "returns error message" do
      it "when drop mark on a column that is full" do
        # Fill all the columns
        6.times { board.drop_mark(2, "X") }
  
        expect(board.drop_mark(2, "O")).to eql "Invalid drop"
      end

      it "when drop mark on non-existing column" do
        expect(board.drop_mark(7, "X")).to eql "Invalid drop"
      end
    end

    context "save dropped mark position" do
      it "when drop mark on the bottom" do
        board.drop_mark(2, "X")
        expect(board.current_drop_position).to eql([2, 5])
      end

      it "when drop a new mark" do
        board.drop_mark(0, "X")
        board.drop_mark(0, "X")
        expect(board.current_drop_position).to eql([0, 4])
      end
    end
  end
end