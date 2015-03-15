class TicTacToe
  def initialize(output)
    @output = output
  end

  def start!
    @output.puts("Which player do you want to be? X or O?\n")
  end

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

Where do you want to move?"
END
    )
  end
end
