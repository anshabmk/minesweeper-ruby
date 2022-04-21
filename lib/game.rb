# frozen_string_literal: true

class Game
  def initialize
    @game_board = GameBoard.new
    @ui = UI.new
  end

  def start_game
    ui.print_welcome_message
    ui.print_instructions

    while !won?
      ui.clear_screen
      ui.print_board(game_board.visible_board)

      user_guess_coordinates = ui.get_user_guess_coordinates

      begin
        game_board.reveal(user_guess_coordinates)
      rescue OutOfBoundCoOrdinatesException => e
        puts e.message
        puts "Press Enter to retry..."
        ui.get_user_input

        next
      end
    end

    puts "You won the game!"
  rescue GameOverException => e
    ui.clear_screen
    ui.print_board(game_board.mine_board)
    puts e.message
    exit!
  rescue UserInterruptException => e
    puts e.message
    exit!
  end

  private

  attr_reader :game_board, :ui

  def won?
    game_board.hidden_tiles_count == game_board.mines_count
  end
end
