# frozen_string_literal: true

class UI
  def initialize
    @prompt = TTY::Prompt.new(interrupt: :exit)
  end

  def print_welcome_message
    puts %q[
      Welcome to Minesweeper.
    ]
  end

  def prompt_start_game
    instructions = %q[
      Provide your guess tile by giving x,y coordinates of the tile.
      For example, to open first row first column give input as 0,0.

      Press Ctrl + C or type "exit" to exit from game anytime.
    ]

    raise UserInterruptException if prompt.select(instructions, %w(Start Exit)) == "Exit"
  end

  def clear_screen
    system("clear")
  end

  def print_board(board)
    print "    "
    puts (0..board.size - 1).to_a.join("  ")
    print "\n"

    board.each_with_index do |row, index|
      print "#{index}   "
      puts row.join("  ")
    end
  end

  def get_user_guess_coordinates
    user_input = prompt.ask("Enter the co-ordinates of your guess? (x, y): ") do |q|
      q.required true
      q.convert -> (input) { input == "exit" ? input : input.split(",").map(&:to_i) }
      q.validate(/(\A\d,\s*\d\s*\z)|(\Aexit\z)/)
      q.messages[:valid?] = "Invalid input: %{value}. must be comma-separated integers (eg:- 1,2)"
    end

    raise UserInterruptException if user_input == "exit"

    CoOrdinates.new(*user_input)
  end

  def print_error_message(message)
    prompt.warn(message)
  end

  def wait_for_keypress(timeout: 3)
    prompt.keypress(
      "Press any key to continue, resumes automatically in 3 seconds ...",
      timeout: timeout
    )
  end

  private

  attr_reader :prompt
end
