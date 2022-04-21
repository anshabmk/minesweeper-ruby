# frozen_string_literal: true

class Game
  def initialize
    @game_board = GameBoard.new
  end

  def start_game
    while !won?
      begin
        system("clear")
        game_board.display

        user_input = prompt_user_input

        exit! if user_input == "exit"

        set_current_guess_coordinates(user_input)
        game_board.reveal(current_guess_coordinates)
      rescue => e
        puts e.message
        exit!
      end
    end

    puts "You won the game!"
  end

  private

  attr_reader :game_board, :current_guess_coordinates

  def won?
    game_board.hidden_tiles_count == game_board.mines_count
  end

  def prompt_user_input
    print "Enter your guess (x, y): "
    gets.chomp
  end

  def set_current_guess_coordinates(user_input)
    x, y = user_input.split(",").map(&:to_i)
    @current_guess_coordinates = CoOrdinates.new(x, y)
  end
end
