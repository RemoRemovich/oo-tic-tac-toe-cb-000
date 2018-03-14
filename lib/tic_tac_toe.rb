class TicTacToe
  @board = []

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " " ]
  end

  def play
    puts "Please enter 1-9:"
    turn
    if won?
      puts "Congratulations #{winner}"
    elsif draw?
      puts "Cat's game!"
    else
      play
    end
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [6, 4, 2],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(inp)
    i = inp.to_i
    if (i > 0 && i <= 9)
      i - 1
    else
      -1
    end
  end

  def turn
    inp = gets.strip || 1
    index = input_to_index(inp)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def move(index, player_token)
    @board[index] = player_token
  end

  def valid_move?(index)
    if (index < 0 || index >= 9) then
      return false
    else
      if position_taken?(index) then
        return false
      else
        return true
      end
    end
  end

  def position_taken?(index)
    (@board[index] == "X" || @board[index] == "O")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|cell| cell == "X" || cell == "O"}
  end

  def won?
    won = false
    tokens = ["X", "O"]
    tokens.each {
      |t| ( WIN_COMBINATIONS.each { |w|
            (if (@board[w[0]] == t && @board[w[1]] == t && @board[w[2]] == t) then
              won = [w[0], w[1], w[2]]
            #else
              #puts "not won"
            end)
            }
          )
    }

    return won
  end

  def winner
    x_winner = nil
    tokens = ["X", "O"]
    tokens.each {
      |t| ( #puts "testing #{t} as a winner"
            WIN_COMBINATIONS.each { |w|
              (if (@board[w[0]] == t && @board[w[1]] == t && @board[w[2]] == t) then
                x_winner = t
              #else
                #puts "#{t} is not a winner"
              end)
            }
          )
    }

    return x_winner
  end

  def draw?
    puts "turns = " + turn_count.to_s
    (!won? && turn_count == 9) ? true : false
  end

  def full?
    draw? ? true : false
  end

  def over?
    (draw? || won?) ? true : false
  end

end
