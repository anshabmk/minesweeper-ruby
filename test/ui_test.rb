# frozen_string_literal: true

require "test_helper"

class UITest < MiniTest::Test
  def setup
    @ui = UI.new
  end

  def test_clear_screen
    _out, err = capture_subprocess_io do
      @ui.clear_screen
    end

    assert_empty(err)
  end
end
