# frozen_string_literal: true

module DieRoll
  # The result of a single die roll.
  class Roll
    attr_reader :sides, :values

    def initialize(sides:, values:)
      @sides = sides
      @values = values
    end

    def total
      values.sum
    end
  end

  private_constant :Roll
end
