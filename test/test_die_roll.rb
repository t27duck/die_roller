# frozen_string_literal: true

require "test_helper"

class TestDieRoll < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DieRoll::VERSION
  end

  def test_roll_processes_a_die
    assert_includes (1..6), DieRoll.roll("1d6").total
  end
end
