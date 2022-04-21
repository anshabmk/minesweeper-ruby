# frozen_string_literal: true

class UserInterruptException < StandardError
  def message
    "Exiting..."
  end
end
