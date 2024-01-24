# frozen_string_literal: true

require "test_helper"

class TestResult < Minitest::Test
  def test_total_is_a_sum_of_rolls
    result = DieRoll.roll("2d4 1d6")

    assert_equal result.total, result.rolls.sum(&:total)
  end

  def test_tokens_are_extracted
    input = "2d4 1d6"
    result = DieRoll.roll(input)

    assert_equal input.split.sort, result.tokens.sort
  end
end
