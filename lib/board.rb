class Board
  attr_accessor :square, :current_drop_position

  def initialize
    @square = []
    @current_drop_position = nil
    # Create multi-dimensional array for columns and rows
    # Outer array is columns and sub array is rows
    7.times { square << Array.new(6) { " " }}
  end

  def display
    line = ""
    7.times { line << "----" }
    puts line

    row = 0

    while row < 6
      row_square = "|"
      7.times { |col| row_square << " #{square[col][row]} |" }

      puts row_square
      puts line

      row += 1
    end
    puts "  0   1   2   3   4   5   6"
  end

  def drop_mark(col, mark)
    return "Invalid drop" if !col.between?(0,6) || square[col][0] != " " 

    row = square[col].length - 1
      
    until row < 0
      if square[col][row] == " "
        square[col][row] = mark
        
        # Save drop position
        @current_drop_position = [col,row]
        break
      end

      row -= 1
    end
    display
  end
end
