# frozen_string_literal: true

require "test_helper"

class TestDieRoller < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DieRoller::VERSION
  end

  def test_roll_processes_a_die
    assert_includes (1..6), DieRoller.roll("1d6").total
  end

  def test_roll_accepts_capital_d
    assert_includes (1..6), DieRoller.roll("1D6").total
  end

  def test_roll_assumes_one_die_if_not_given
    assert_includes (1..6), DieRoller.roll("d6").total
  end

  def test_roll_processes_multiple_dice
    assert_includes (1..10), DieRoller.roll("1d6 1d4").total
    assert_includes (1..10), DieRoller.roll(" 1d6  1d4 ").total
  end

  def test_roll_raises_on_too_small_a_die
    assert_raises(DieRoller::DieSizeError) do
      DieRoller.roll("1d#{DieRoller::MINIMUM_DIE_SIZE - 1}")
    end
  end

  def test_roll_raises_on_invalid_input
    assert_raises(DieRoller::ParseError) { DieRoller.roll("-d4") }
    assert_raises(DieRoller::ParseError) { DieRoller.roll("4") }
    assert_raises(DieRoller::ParseError) { DieRoller.roll("2d8 x") }
    assert_raises(DieRoller::ParseError) { DieRoller.roll("abcd") }
    assert_raises(DieRoller::ParseError) { DieRoller.roll("2d6 7d-9") }
    assert_raises(DieRoller::ParseError) { DieRoller.roll("323dx3") }
    assert_raises(DieRoller::ParseError) { DieRoller.roll("2d6+2d8") }
    assert_raises(DieRoller::ParseError) { DieRoller.roll("2d6 + 2d8") }
  end
end
