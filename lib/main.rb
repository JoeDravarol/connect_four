require './lib/board'
require './lib/player'
require './lib/win_condition'

class Game
  attr_accessor :board, :player_1, :player_2, :current_player, :win_condition
  # Only use for testing
  attr_reader :name_1, :name_2

  def initialize
    @board = Board.new
    @win_condition = WinCondition.new

    @name_1 = get_name("player 1")
    @player_1 = Player.new(name_1, "\u2600")

    @name_2 = get_name("player 2")
    @player_2 = Player.new(name_2, "\u263C")
    @current_player = player_1

    play_game
  end

  def get_name(player)
    puts "Hi #{player}, what is your name?"
    name = gets.chomp.capitalize
    puts "Nice to meet you #{name}"
    name
  end

  def display_instructions
    puts "***************************************"
    puts "** Welcome To The Connect Four Game! **"
    puts "***************************************"
    puts "======================================="
    puts "***************************************"
    puts "************ Instructions *************"
    puts "***************************************"
    puts "======================================="
    puts "1. The goal of this game is to get four"
    puts "of your mark in line up horizontally, vertically, or diagonally."
    puts "2. The players takes turn to drop their mark"
    puts "in  a column by entering the column number (shown below the board)."
    puts "3. If the board is filled, with no victors, it will be a draw."
    puts "#{player_1.name}, your mark is #{player_1.mark}"
    puts "#{player_2.name}, your mark is #{player_2.mark}"
    puts "Good luck and have fun!"
  end

  def get_mark(player)
    puts "It's your turn #{player.name}"
    puts "Select a column to drop your mark"

    col = gets.chomp

    until col_valid?(col)
      "Please enter a valid input"
      col = gets.chomp
    end

    col.to_i
  end

  def col_valid?(col)
    # Because the regex returns nil when it's not match, the ternary operator makes it so that it returns false
    !col.empty? && col.length == 1 && col =~ (/\d+/) && col.to_i.between?(0,6) ? true : false
  end

  def drop_mark(player)    
    loop do
      col = get_mark(player)
      break unless player.drop_mark(col, board) == "Invalid drop"
      puts "Invalid drop"
    end
  end

  def switch_player
    @current_player = current_player == player_1 ? player_2 : player_1
  end

  def play_game
    display_instructions
    board.display

    loop do
      col = drop_mark(current_player)
      break if game_ended?(current_player, board)
      switch_player
    end
  end

  def game_ended?(player, board)
    if won?(player, board)
      puts "Game Over! #{player.name} has won!"
      return true
    elsif draw?(board)
      puts "Game Over! It's a draw"
      return true
    end
    false
  end

  def won?(player, board)
    win_condition.win?(board.current_drop_position, player.mark, board)
  end

  def draw?(board)
    win_condition.draw?(board)
  end
end

game = Game.new