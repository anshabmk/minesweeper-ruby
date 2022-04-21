# frozen_string_literal: true

require "ostruct"
require_relative "./game.rb"
require_relative "./game_board.rb"
require_relative "./co_ordinates.rb"
require_relative "./exceptions/game_over_exception.rb"

trap("SIGINT") { exit! }
