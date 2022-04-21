# frozen_string_literal: true

require "ostruct"

require_relative "./game.rb"
require_relative "./game_board.rb"
require_relative "./ui.rb"
require_relative "./co_ordinates.rb"

require_relative "./exceptions/game_over_exception.rb"
require_relative "./exceptions/user_interrupt_exception.rb"
require_relative "./exceptions/out_of_bound_co_ordinates_exception.rb"

trap("SIGINT") { exit! }
