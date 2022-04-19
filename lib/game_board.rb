# frozen_string_literal: true

class GameBoard
  DEFAULT_BOARD_SIZE = 9
  DIFFICULTY_LEVEL = { easy: 0.15, medium: 0.25, hard: 0.5 }.freeze
  EMPTY_TILE = "0"
  HIDDEN_TILE = "-"
  MINE = "x"

  def initialize(board_size: DEFAULT_BOARD_SIZE, difficulty: :easy)
    @board_size = board_size
    @difficulty = DIFFICULTY_LEVEL[difficulty]

    set_game_boards
  end

  def display
    visible_board.each { |row| puts row.join("  ") }
  end

  private

  attr_reader :board_size, :difficulty, :mine_board, :visible_board

  def set_game_boards
    @mine_board = generate_mine_board
    @visible_board = create_board(HIDDEN_TILE)
  end

  def generate_mine_board
    mines_planted = 0
    empty_board = create_board(EMPTY_TILE)

    empty_board.map do |row|
      row.map do |cell|
        next cell if (mines_planted >= max_allowed_mines) || random_boolean_val

        mines_planted += 1
        MINE
      end
    end
  end

  def max_allowed_mines
    @_max_allowed_mines ||= (board_size * board_size * difficulty).to_i
  end

  def create_board(ele)
    Array.new(board_size) { Array.new(board_size, ele) }
  end

  def random_boolean_val
    rand < 0.5
  end
end
