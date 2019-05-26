class WinCondition

  def draw?(board)
    flatten_board = board.square.flatten
    flatten_board.all? { |square| square != " " }
  end

  def win?(position, mark, board)
    won = false

    4.times do |i|
      case i
      when 0
        won = check_horizontal(position, mark, board)
        break if won
      when 1
        won = check_vertical(position, mark, board)
        break if won
      when 2
        won = check_diagonal_left(position, mark, board)
        break if won
      when 3
        won = check_diagonal_right(position, mark, board)
        break if won
      end
    end

    won
  end

  def check_horizontal(position, mark, board)
    counter = 1
    col,row = position
  
    # Right
    1.upto(3) do |i|
      break if !(col+i).between?(0,6) || board.square[col+i][row] != mark
      counter += 1
    end
      
    # Left
    1.upto(3) do |i|
      break if !(col-i).between?(0,6) || board.square[col-i][row] != mark
      counter += 1
    end
  
    counter == 4
  end
  
  def check_vertical(position, mark, board)
    counter = 1
    col,row = position
  
    # Down
    1.upto(3) do |i|
      break if !(row+i).between?(0,5) || board.square[col][row+i] != mark
      counter += 1
    end
  
    counter == 4
  end

  def check_diagonal_left(position, mark, board)
    counter = 1
    col,row = position

    # Up Left
    1.upto(3) do |i|
      break if !(col-i).between?(0,6) || !(row-i).between?(0,5) || board.square[col-i][row-i] != mark
      counter += 1
    end
    
    # Down Right
    1.upto(3) do |i|
      break if !(col+i).between?(0,6) || !(row+i).between?(0,5) || board.square[col+i][row+i] != mark
      counter += 1
    end

    counter == 4
  end

  def check_diagonal_right(position, mark, board)
    counter = 1
    col,row = position

    # Up Right
    1.upto(3) do |i|
      break if !(col+i).between?(0,6) || !(row-i).between?(0,5) || board.square[col+i][row-i] != mark
      counter += 1
    end

    # Down Left
    1.upto(3) do |i|
      break if !(col-i).between?(0,6) || !(row+i).between?(0,5) || board.square[col-i][row+i] != mark
      counter += 1
    end

    counter == 4
  end
end

