require 'main'

RSpec.describe Game do
  let(:game) { @game = Game.new }

  describe "#initialize" do
    context "Create a board" do
      it "creates a 7 column square" do
        expect(game.board.square.length).to eql(7)
      end
  
      it "creates a 6 row squares" do
        game.board.square.each do |row|
          expect(row.length).to eql(6)
        end
      end
    end

    it "get player 1 name" do
      expect(game.player_1.name).to eql game.name_1
    end

    it "get player 2 name" do
      expect(game.player_2.name).to eql game.name_2
    end
  end

  describe "#col_valid?" do
    it "returns true when column entered is between 0 to 6" do
      6.times do |col|
        expect(game.col_valid?("#{col}")).to eql(true)
      end
    end

    context "returns false" do
      it "when given emtpy input" do
        expect(game.col_valid?("")).to eql(false)
      end

      it "when input is a space" do
        expect(game.col_valid?(" ")).to eql(false)
      end

      it "when a character is entered" do
        expect(game.col_valid?("X")).to eql(false)
      end

      it "when a string is entered" do
        expect(game.col_valid?("space")).to eql(false)
      end

      it "when the column entered in not between 0 to 6" do
        expect(game.col_valid?("20")).to eql(false)
      end
    end
  end

  describe "#switch_player" do
    it "switch from player 1 to player 2" do
      game.current_player = game.player_1
      game.switch_player

      expect(game.current_player).to eql(game.player_2)
    end

    it "switch from player 2 to player 1" do
      game.current_player = game.player_2
      game.switch_player

      expect(game.current_player).to eql(game.player_1)
    end
  end
end