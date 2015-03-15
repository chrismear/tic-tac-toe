class TicTacToe
  def initialize(output)
    @output = output
  end

  def start!
    @output.puts("Which player do you want to be? X or O?\n")
  end

  # Takes a line of user input, writes a response to the output as necessary,
  # and returns TicTacToe::GameOver if the game is finished.
  def input(user_input)
    @output.puts(
<<-END
          A   B   C

        +---+---+---+
    1   | X |   |   |
        +---+---+---+
    2   |   |   |   |
        +---+---+---+
    3   |   |   |   |
        +---+---+---+

Where do you want to move?
END
    )

    return GameOver
  end

  class GameOver; end
end
