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

  def test_get_user_input_exit
    assert_raises UserInterruptException do
      string_io = StringIO.new
      string_io.puts "exit"
      string_io.rewind
      $stdin = string_io

      @ui.get_user_input

      $stdin = STDIN
    end
  end

  def test_get_user_guess_co_ordinates
    string_io = StringIO.new

    string_io.puts "1,2"
    string_io.rewind

    $stdin = string_io

    co_ordinates, _stdout, _stderr = OStreamCatcher.catch do
      @ui.get_user_guess_coordinates
    end

    $stdin = STDIN

    assert_instance_of(CoOrdinates, co_ordinates)
    assert_equal(co_ordinates.x, 1)
    assert_equal(co_ordinates.y, 2)
  end
end
