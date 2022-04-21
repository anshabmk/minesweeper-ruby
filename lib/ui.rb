# frozen_string_literal: true

class UI
  def print_welcome_message
    puts %q[
      Welcome to Minesweeper.
    ]
  end

  def print_instructions
    puts %q[
      Provide your guess tile by giving x,y coordinates of the tile.
      For example, to open first row first column give input as 0,0.

      Press Ctrl + C or type "exit" to exit from game anytime.
      Press "Enter" key to start the game...
    ]

    get_user_input
  end

  def clear_screen
    system("clear")
  end

  def print_board(board)
    board.each { |row| puts row.join("  ") }
  end

  def get_user_guess_coordinates
    print "Enter your guess (x, y): "

    x, y = get_user_input.split(",").map(&:to_i)

    CoOrdinates.new(x, y)
  end

  def get_user_input
    user_input = gets.chomp

    raise UserInterruptException if user_input == "exit"

    user_input
  end
end
