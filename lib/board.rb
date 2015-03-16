class Board
  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  attr_reader :board

  # Returns a string representing the mark at the given column and row.
  # If the board is empty at that column and row, ' ' is returned.
  def character_at(column, row)
    case @board[column][row]
    when :x
      'X'
    when :o
      'O'
    else
      ' '
    end
  end

  # Returns true if the board is empty at the given column and row.
  def empty_at?(column, row)
    @board[column][row].nil?
  end

  # mark accepts :x or :o, and writes the appropriate marker into the
  # board.
  def play(mark, column, row)
    raise ArgumentError unless [:x, :o].include?(mark)
    @board[column][row] = mark
  end
end
