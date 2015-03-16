require File.join(File.dirname(__FILE__), 'board')

class TicTacToe
  attr_accessor :state

  def initialize(output)
    @output = output
    @board = Board.new
  end

  def start!
    @output.puts("Which player do you want to be? X or O?\n")
    @state = :choosing_players
  end

  # Takes a line of user input, writes a response to the output as necessary,
  # and returns TicTacToe::GameOver if the game is finished.
  def input(user_input)
    user_input = user_input.chomp
    case @state
    when :choosing_players
      choose_player(user_input)
    else
      play_user_turn(user_input)
      if game_over?
        draw_board
        @output << "\nYou have won!\n"
        return GameOver
      end

      play_computer_turn
      if game_over?
        draw_board
        @output << "\nI have won!\n"
        return GameOver
      end

      draw_board
      prompt_for_turn
    end
  end

  def game_over?
    all_lines = [
      # columns
      [[0,0], [0,1], [0,2]],
      [[1,0], [1,1], [1,2]],
      [[2,0], [2,1], [2,2]],
      # rows
      [[0,0], [1,0], [2,0]],
      [[0,1], [1,1], [2,1]],
      [[0,2], [1,2], [2,2]],
      # diagonals
      [[0,0], [1,1], [2,2]],
      [[0,2], [1,1], [2,0]]
    ].each do |line|
      # Look up what marks exist on the board along this line:
      marks_on_line = line.map{|column_row| @board.mark_at(*column_row)}
      if marks_on_line == [:x, :x, :x]
        return :x
      elsif marks_on_line == [:o, :o, :o]
        return :o
      end
    end
    # If we reach here, no line is in a winning state.
    return nil
  end

  def choose_player(user_input)
    if user_input == 'x' || user_input == 'X'
      @user_player = :x
      @computer_player = :o
      @state = :playing
      draw_board
      prompt_for_turn
    elsif user_input == 'o' || user_input == 'O' || user_input == '0'
      @user_player = :o
      @computer_player = :x
      @state = :playing
      play_computer_turn
      draw_board
      prompt_for_turn
    else
      @output.puts("Which player do you want to be? X or O?\n")
    end
  end

  def prompt_for_turn
    @output << "\nWhere do you want to move?\n"
  end

  # Takes the user input, and places their move into the board.
  def play_user_turn(user_input)
    column = case user_input.chars[0]
    when 'a', 'A'
      0
    when 'b', 'B'
      1
    when 'c', 'C'
      2
    end

    row = case user_input.chars[1]
    when '1'
      0
    when '2'
      1
    when '3'
      2
    end

    if @board.empty_at?(column, row)
      @board.play(@user_player, column, row)
    else
      # TODO: Handle invalid user play.
    end
  end

  # Thinks hard about the current board state, chooses a move to make, and
  # places it into the board.
  def play_computer_turn
    # TODO Make this smarter; current implementation simply plays in the first available space.
    (0..2).each do |row|
      (0..2).each do |column|
        if @board.empty_at?(column, row)
          @board.play(@computer_player, column, row)
          return
        end
      end
    end

  end

  def draw_board
    board_output = ""
    board_output << <<-END
          A   B   C

        +---+---+---+
END
    board_output << "    1   | #{@board.character_at(0,0)} | #{@board.character_at(1,0)} | #{@board.character_at(2,0)} |\n"
    board_output << "        +---+---+---+\n"
    board_output << "    2   | #{@board.character_at(0,1)} | #{@board.character_at(1,1)} | #{@board.character_at(2,1)} |\n"
    board_output << "        +---+---+---+\n"
    board_output << "    3   | #{@board.character_at(0,2)} | #{@board.character_at(1,2)} | #{@board.character_at(2,2)} |\n"
    board_output << "        +---+---+---+\n"
    @output << board_output
  end

  def update_board(board_shorthand)
    @board = Board.new(board_shorthand)
  end

  def user_player=(user_mark)
    case user_mark
    when :x
      @user_player = :x
      @computer_player = :o
    when :o
      @user_player = :o
      @computer_player = :x
    end
  end

  class GameOver; end
end
