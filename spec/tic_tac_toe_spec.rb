require 'tic_tac_toe'

describe 'Tic-tac-toe' do

  let(:output){StringIO.new}
  let(:ttt){TicTacToe.new(output)}

  def start_game
    @last_output_position = output.pos
    ttt.start!
  end

  def type(user_input)
    @last_output_position = output.pos
    ttt.input(user_input)
  end

  def response
    output.pos = @last_output_position
    result = output.gets(nil) # nil ensures we don't stop reading when we hit a newline.
    @last_output_position = output.pos
    result
  end

  it 'plays a first move' do
    start_game
    expect(response).to eq("Which player do you want to be? X or O?\n")
    type('O')
    expect(response).to eq(
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
  end

  it 'allows the user to play the first move' do
    start_game
    type('X')
    expect(response).to eq(
<<-END
          A   B   C

        +---+---+---+
    1   |   |   |   |
        +---+---+---+
    2   |   |   |   |
        +---+---+---+
    3   |   |   |   |
        +---+---+---+

Where do you want to move?
END
    )
    type('A1')
    expect(response).to eq(
<<-END
          A   B   C

        +---+---+---+
    1   | X | O |   |
        +---+---+---+
    2   |   |   |   |
        +---+---+---+
    3   |   |   |   |
        +---+---+---+

Where do you want to move?
END
    )
  end

  it 'complains when the user makes an invalid move'
  it 'finishes the game when the user wins'
  it 'finishes the game when the computer wins'
  it 'finishes the game when there is a draw'
end
