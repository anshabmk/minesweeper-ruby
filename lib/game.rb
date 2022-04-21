# frozen_string_literal: true

class Game
  def initialize
    @game_board = GameBoard.new
    @ui = UI.new
  end

  def start_game
    ui.print_welcome_message
    ui.prompt_start_game

    while !won?
      ui.clear_screen
      ui.print_board(game_board.visible_board)

      begin
        user_guess_coordinates = ui.get_user_guess_coordinates
        game_board.reveal(user_guess_coordinates)
      rescue OutOfBoundCoOrdinatesException, InvalidCoOrdinatesException => e
        ui.print_error_message(e.message)
        ui.wait_for_keypress(timeout: 3)
        next
      end
    end

    puts "You won the game!"
  rescue GameOverException => e
    ui.clear_screen
    ui.print_board(game_board.mine_board)
    ui.print_error_message(e.message)
    exit!
  rescue UserInterruptException => e
    ui.print_error_message(e.message)
    exit!
  end

  private

  attr_reader :game_board, :ui

  def won?
    game_board.hidden_tiles_count == game_board.mines_count
  end
end
