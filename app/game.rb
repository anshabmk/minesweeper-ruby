# frozen_string_literal: true

require "ostruct"

class Game
  SQUARE_SIZE = 9

  def initialize
    @board = Array.new(SQUARE_SIZE) { Array.new(SQUARE_SIZE, "-") }
    @board_with_mines = generate_random_mines(@board)
    @total_num_of_mines = @board_with_mines.flatten.count("x")
    @revealed_tiles = []
  end

  def start_game
    loop do
      display_board

      guess_input = get_input

      break if guess_input == "exit"

      x, y = guess_input.split(",").map(&:to_i)

      if @board_with_mines[x][y] == "x"
        puts "Game Over. Exiting..."
        break
      else
        reveal_tile(x, y)

        if @board.flatten.count("-") == @total_num_of_mines
          puts "You won the game!"
          break
        end
      end
    end
  end

  private

  def reveal_tile(x, y)
    return if @revealed_tiles.include?([x, y])

    @revealed_tiles << [x, y]

    neighbors = neighbors(@board_with_mines, x, y)
    num_of_adj_mines = neighbors.map(&:value).count("x")

    if num_of_adj_mines.zero?
      @board[x][y] = "\u2713".encode

      neighbors.map(&:coords).each do |coords|
        reveal_tile(coords.first, coords.last)
      end
    else
      @board[x][y] = num_of_adj_mines
    end
  end

  def get_input
    print "Enter your guess (x, y): "
    gets.chomp
  end

  def display_board
    system("clear")

    SQUARE_SIZE.times do |i|
      print @board[i].join(" ")
      print "\t"
      puts @board_with_mines[i].join(" ")
    end
  end

  def neighbors(board, x, y)
    result = []
    possible_x1_values = [x - 1, x, x + 1]
    possible_y1_values = [y - 1, y, y + 1]

    possible_x1_values.each do |x1|
      next unless x1.between?(0, SQUARE_SIZE - 1)

      possible_y1_values.each do |y1|
        next unless y1.between?(0, SQUARE_SIZE - 1)
        next if (x1 == x) && (y1 == y)

        result << OpenStruct.new(coords: [x1, y1], value: board[x1][y1])
      end
    end

    result
  end

  def generate_random_mines(board)
    random_bool_arr = [true, false, false]
    max_num_of_mines = 20
    mines_count = 0

    board.map do |row|
      row.map do |cell|
        if mines_count < max_num_of_mines && random_bool_arr.sample && random_bool_arr.sample
          mines_count += 1
          "x"
        else
          "o"
        end
      end
    end
  end
end
