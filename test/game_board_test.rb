# frozen_string_literal: true

require "test_helper"

class GameBoardTest < MiniTest::Test
  def setup
    @game_board = GameBoard.new(board_size: 10, difficulty: :easy)
  end

  def test_hidden_tiles_count
    total_tiles_count = 10 * 10

    assert_equal(@game_board.hidden_tiles_count, total_tiles_count)

    @game_board.visible_board[0][0] = GameBoard::TICK

    assert_equal(@game_board.hidden_tiles_count, total_tiles_count - 1)
  end

  def test_reveal_empty_tile
    valid_co_ordinates = CoOrdinates.new(1, 2)
    @game_board.mine_board[valid_co_ordinates.x][valid_co_ordinates.y] = GameBoard::EMPTY_TILE

    assert_equal(
      @game_board.visible_board[valid_co_ordinates.x][valid_co_ordinates.y],
      GameBoard::HIDDEN_TILE
    )

    @game_board.reveal(valid_co_ordinates)

    refute_equal(
      @game_board.visible_board[valid_co_ordinates.x][valid_co_ordinates.y],
      GameBoard::HIDDEN_TILE
    )
  end

  def test_reveal_invalid_co_ordinates
    invalid_co_ordinates = CoOrdinates.new(@game_board.board_size, 5)

    assert_raises OutOfBoundCoOrdinatesException do
      @game_board.reveal(invalid_co_ordinates)
    end
  end

  def test_reveal_mine
    @game_board.mine_board[0][0] = GameBoard::MINE
    mine_co_ordinates = CoOrdinates.new(0, 0)

    assert_raises GameOverException do
      @game_board.reveal(mine_co_ordinates)
    end
  end

  def test_reveal_empty_tile_with_adj_mines
    mine_co_ordinates = CoOrdinates.new(0, 0)
    adj_empty_tile_co_ordinates = CoOrdinates.new(0, 1)
    @game_board.mine_board[mine_co_ordinates.x][mine_co_ordinates.y] = GameBoard::MINE
    @game_board.mine_board[adj_empty_tile_co_ordinates.x][adj_empty_tile_co_ordinates.y] =
      GameBoard::EMPTY_TILE

    @game_board.reveal(adj_empty_tile_co_ordinates)

    assert_kind_of(
      Integer,
      @game_board.visible_board[adj_empty_tile_co_ordinates.x][adj_empty_tile_co_ordinates.y]
    )
  end
end
