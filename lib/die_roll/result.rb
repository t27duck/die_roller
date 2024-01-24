# frozen_string_literal: true

module DieRoll
  # Holds the final result of rolls.
  class Result
    attr_reader :tokens, :rolls

    def initialize(rolls:, tokens:)
      @rolls = rolls
      @tokens = tokens
    end

    def total
      @rolls.sum(&:total)
    end
  end

  private_constant :Result
end
