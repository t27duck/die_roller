# frozen_string_literal: true

require "test_helper"

class TestResult < Minitest::Test
  def test_total_is_a_sum_of_rolls
    result = DieRoller.roll("2d4 1d6")

    assert_equal result.total, result.rolls.sum(&:value)
  end

  def test_tokens_are_extracted
    input = "2d4 1d6"
    result = DieRoller.roll(input)

    assert_equal input.split.sort, result.tokens.sort
  end

  def test_dice_return_each_die
    input = "2d4 1d6"
    result = DieRoller.roll(input)

    assert_equal %w[d4 d4 d6], result.dice
  end

  def test_values_return_each_die_value
    input = "2d4 1d6"
    result = DieRoller.roll(input)

    assert_equal result.values, result.rolls.map(&:value)
  end
end
