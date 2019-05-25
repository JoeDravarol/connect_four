class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def drop_mark(col, board)
    board.drop_mark(col, mark)
  end
end