class Board
  INITIAL_MARKER = " "
  WINNING_KEYS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new(INITIAL_MARKER)}
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked?}
  end

  def board_full?
    unmarked_keys.empty?
  end

  def human_won?
    WINNING_KEYS.each do |win_squares|
      return true if win_squares.all? {|key| @squares[key].marker == TTTGame::HUMAN_MARKER}
    end
    false
  end

  def computer_won?
    WINNING_KEYS.each do |win_squares|
      return true if win_squares.all? {|key| @squares[key].marker == TTTGame::COMPUTER_MARKER}
    end
    false
  end

  def someone_won?
    human_won? || computer_won?
  end
end

class Square
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == Board::INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

end

class TTTGame
  attr_reader :board, :human, :computer
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!  Goodbye!"
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do 
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def display_result
    display_board
    if board.someone_won?
      puts "You won!" if board.human_won?
      puts "Sorry, the computer won this time." if board.computer_won?
    else
      puts "It's a tie!"
    end
  end

  def display_board(clear = true)
    system "clear" if clear
    puts "You are a #{human.marker}.  Computer is a #{computer.marker}"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def play_again? 
    answer = nil
    loop do
      puts "Would you like to play again (y/n)?"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
    end
    answer == 'y'
  end

  
  def play
    system "clear"
    display_welcome_message
    loop do
      display_board(false)
      loop do
        human_moves
        break if board.board_full? || board.someone_won?

        computer_moves
        display_board
        break if board.board_full? || board.someone_won?
      end
      display_result
      break unless play_again?
      board.reset
      system "clear"
      puts "Let's play again!"
    end
    display_goodbye_message

  end
end

game = TTTGame.new
game.play