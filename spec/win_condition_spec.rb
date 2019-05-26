require 'win_condition'
require 'board'

RSpec.describe WinCondition do
  let(:board) { @board = Board.new }
  let(:player) { @player = Player.new("John", "X") }
  let(:win_condition) { @win_condition = WinCondition.new }

  describe '#draw?' do
    it "returns true when the board is full" do
      # Fill board
      board.square = []
      7.times { board.square << Array.new(6) { "X" }}
      
      expect(win_condition.draw?(board)).to eql(true)
    end

    it "returns false when the board is empty" do
      expect(win_condition.draw?(board)).to eql(false)
    end

    it "returns false when the board is partially filled" do
      # Fill 3 columns
      board.square.each_with_index do |col, i|
        col.each { |square| square = "X" } if i % 2 == 0
      end

      expect(win_condition.draw?(board)).to eql(false)
    end
  end

  describe '#win?' do
    context "horizontal line" do
      it "returns true for right line" do
        6.downto(3) { |i| board.drop_mark(i, player.mark) }
        expect(win_condition.win?(board.current_drop_position, player.mark, board)).to eql(true)
      end

      it "returns true for left line" do
        4.times { |i| board.drop_mark(i, player.mark) }
        expect(win_condition.win?(board.current_drop_position, player.mark, board)).to eql(true)
      end
    end

    it "returns true for vertical line" do
      4.times { board.drop_mark(0, player.mark) }
      expect(win_condition.win?(board.current_drop_position, player.mark, board)).to eql(true)
    end

    context "diagonal line" do
      it "returns true for up left line" do
        board.square[3][2] = "X"
        board.square[4][3] = "X"
        board.square[5][4] = "X"
        board.display
        board.drop_mark(6, player.mark)

        expect(win_condition.win?(board.current_drop_position, player.mark, board)).to eql(true)
      end

      it "returns true for up right line" do
        board.square[3][2] = "X"
        board.square[2][3] = "X"
        board.square[1][4] = "X"
        board.drop_mark(0, player.mark)

        expect(win_condition.win?(board.current_drop_position, player.mark, board)).to eql(true)
      end

      it "returns true for down left line" do
        board.square[0][5] = "X"
        board.square[1][4] = "X"
        board.square[2][3] = "X"
        
        4.times do |i|
          if i == 3
            board.drop_mark(3, player.mark)
          else
            board.drop_mark(3, "O")
          end
        end
        
        expect(win_condition.win?(board.current_drop_position, player.mark, board)).to eql(true)
      end

      it "returns true for down right line" do
        board.square[6][5] = "X"
        board.square[5][4] = "X"
        board.square[4][3] = "X"
        
        4.times do |i|
          if i == 3
            board.drop_mark(3, player.mark)
          else
            board.drop_mark(3, "O")
          end
        end
        
        expect(win_condition.win?(board.current_drop_position, player.mark, board)).to eql(true)
      end
    end
  end

end