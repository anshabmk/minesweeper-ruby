# frozen_string_literal: true

class CoOrdinates
  attr_reader :x, :y

  def initialize(x, y)
    raise InvalidCoOrdinatesException unless x.is_a?(Integer) && y.is_a?(Integer)

    @x = x
    @y = y
  end

  def ==(another_coordinates)
    self.x == another_coordinates.x && self.y == another_coordinates.y
  end
end
