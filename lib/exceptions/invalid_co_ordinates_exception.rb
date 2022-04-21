# frozen_string_literal: true

class InvalidCoOrdinatesException < StandardError
  def message
    "Co-ordinates are invalid."
  end
end
