# frozen_string_literal: true

class CoOrdinates
  attr_reader :x, :y

  def initialize(x, y)
    raise InvalidCoOrdinatesException if !x&.integer? || !y&.integer?

    @x = x
    @y = y
  end

  def ==(another_coordinates)
    self.x == another_coordinates.x && self.y == another_coordinates.y
  end
end
