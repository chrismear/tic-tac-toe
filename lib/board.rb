class Board
  def initialize(board_shorthand=nil)
    if board_shorthand
      @board = [
        [board_shorthand[0], board_shorthand[3], board_shorthand[6]],
        [board_shorthand[1], board_shorthand[4], board_shorthand[7]],
        [board_shorthand[2], board_shorthand[5], board_shorthand[8]]
      ]
    else
      @board = [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ]
    end
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

  # Returns the mark at the given column and row
  def mark_at(column, row)
    @board[column][row]
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
