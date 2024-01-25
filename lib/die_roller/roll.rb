# frozen_string_literal: true

module DieRoller
  # The result of a single die roll.
  class Roll
    attr_reader :sides, :value

    def initialize(sides:, value:)
      @sides = sides
      @value = value
    end

    def die
      "d#{sides}"
    end
  end

  private_constant :Roll
end
