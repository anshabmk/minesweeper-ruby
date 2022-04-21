# frozen_string_literal: true

class OutOfBoundCoOrdinatesException < StandardError
  def message
    "Co-ordinates are out of bound of game board."
  end
end
