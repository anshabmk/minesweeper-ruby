# frozen_string_literal: true

class GameBoard
  DEFAULT_BOARD_SIZE = 9
  DIFFICULTY_LEVEL = { easy: 0.15, medium: 0.25, hard: 0.5 }.freeze
  EMPTY_TILE = "0"
  HIDDEN_TILE = "-"
  MINE = "x"
  TICK = "\u2713".encode

  attr_reader :mine_board, :visible_board, :board_size, :difficulty

  def initialize(board_size: DEFAULT_BOARD_SIZE, difficulty: :easy)
    @board_size = board_size
    @difficulty = DIFFICULTY_LEVEL[difficulty]
    @revealed_tiles = []

    set_game_boards
  end

  def reveal(coords)
    raise OutOfBoundCoOrdinatesException unless valid_coordinates?(coords)
    raise GameOverException if mine_board[coords.x][coords.y] == MINE

    return if revealed_tiles.include?(coords)

    revealed_tiles << coords

    neighbors = neighbors(coords)
    num_of_adj_mines = neighbors.map(&:value).count(MINE)

    if num_of_adj_mines.zero?
      visible_board[coords.x][coords.y] = TICK

      neighbors.map(&:coords).each { |co_ordinates| reveal(co_ordinates) }
    else
      visible_board[coords.x][coords.y] = num_of_adj_mines
    end
  end

  def hidden_tiles_count
    visible_board.flatten.count(HIDDEN_TILE)
  end

  def mines_count
    @_mines_count ||= mine_board.flatten.count(MINE)
  end

  private

  attr_reader :revealed_tiles

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

  def neighbors(coords)
    result = []
    possible_x1_values = [coords.x - 1, coords.x, coords.x + 1]
    possible_y1_values = [coords.y - 1, coords.y, coords.y + 1]

    possible_x1_values.each do |x1|
      next unless x1.between?(0, board_size - 1)

      possible_y1_values.each do |y1|
        next unless y1.between?(0, board_size - 1)
        next if (x1 == coords.x) && (y1 == coords.y)

        result << OpenStruct.new(coords: CoOrdinates.new(x1, y1), value: mine_board[x1][y1])
      end
    end

    result
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

  def valid_coordinates?(coordinates)
    [coordinates.x, coordinates.y].all? { |val| val.between?(0, board_size - 1) }
  end
end
