# frozen_string_literal: true

class GameOverException < StandardError
  def message
    "Boom! Mine blasted. Game Over!"
  end
end
