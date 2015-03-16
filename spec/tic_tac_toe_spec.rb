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

  # board takes an array of :x, :o and nil to indicate the current position of the board,
  # It is assumed that the user is to play next, and you must pass an :x or an :o
  # to the player_mark argument to indicate which mark the user is playing with.
  # e.g. make_game_in_progress(:x, [nil, nil, nil, :x, :o, :x, :o, nil nil])
  def make_game_in_progress(player_mark, board_shorthand)
    ttt.update_board(board_shorthand)
    ttt.user_player = player_mark
    ttt.state = :playing
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

  it 'finishes the game when the user wins' do
    # User is playing as X
    # Current board is:
    # X O O
    #   X
    # 
    # User is to play next.
    make_game_in_progress(:x, [:x, :o, :o, nil, :x, nil, nil, nil, nil])
    type('C3')
    expect(response).to eq(
<<-END
          A   B   C

        +---+---+---+
    1   | X | O | O |
        +---+---+---+
    2   |   | X |   |
        +---+---+---+
    3   |   |   | X |
        +---+---+---+

You have won!
END
    )
  end

  it 'finishes the game when the computer wins' do
    # User is playing as X
    # Current board is:
    # O O
    #  
    # X X
    # User is to play next.
    make_game_in_progress(:x, [:o, :o, nil, nil, nil, nil, :x, :x, nil])
    # Let the computer win.
    type('A2')
    expect(response).to eq(
<<-END
          A   B   C

        +---+---+---+
    1   | O | O | O |
        +---+---+---+
    2   | X |   |   |
        +---+---+---+
    3   | X | X |   |
        +---+---+---+

I have won!
END
    )
  end


  it 'finishes the game when there is a draw' do
    # User is playing as O
    # Current board is:
    # X O
    # X O
    # O X O
    # User is to play next.
    make_game_in_progress(:o, [:x, :o, nil, :x, :o, nil, :o, :x, :o])
    type('C2')
    expect(response).to eq(
<<-END
          A   B   C

        +---+---+---+
    1   | X | O | X |
        +---+---+---+
    2   | X | O | O |
        +---+---+---+
    3   | O | X | O |
        +---+---+---+

It's a draw!
END
    )
  end
end
