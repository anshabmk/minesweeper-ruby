# frozen_string_literal: true

require "ostruct"
require_relative "../lib/game_board.rb"
require_relative "../lib/co_ordinates.rb"

class Game
  def initialize
    @game_board = GameBoard.new
  end

  def start_game
    loop do
      system("clear")
      game_board.display
      puts game_board.hidden_tiles_count
      puts game_board.mines_count
      if game_board.hidden_tiles_count == game_board.mines_count
        puts "You won the game!"
        break
      end

      user_input = prompt_user_input

      break if user_input == "exit"

      set_current_guess_coordinates(user_input)
      game_board.reveal(current_guess_coordinates)
    rescue => e
      puts e.message
      break
    end
  end

  private

  attr_reader :game_board, :current_guess_coordinates

  def prompt_user_input
    print "Enter your guess (x, y): "
    gets.chomp
  end

  def set_current_guess_coordinates(user_input)
    x, y = user_input.split(",").map(&:to_i)
    @current_guess_coordinates = CoOrdinates.new(x, y)
  end
end
