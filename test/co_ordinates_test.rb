# frozen_string_literal: true

require "test_helper"

class CoOrdinatesTest < MiniTest::Test
  def setup
    @co_ordinates = CoOrdinates.new(10, 20)
  end

  def test_equality
    co_ordinates1 = CoOrdinates.new(10, 20)

    assert_equal(@co_ordinates, co_ordinates1)
  end

  def test_readers
    assert_equal(@co_ordinates.x, 10)
    assert_equal(@co_ordinates.y, 20)
  end
end
