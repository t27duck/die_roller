# frozen_string_literal: true

module DieRoller
  # Holds the final result of rolls.
  class Result
    attr_reader :tokens, :rolls

    def initialize(rolls:, tokens:)
      @rolls = rolls
      @tokens = tokens
    end

    def pairs
      @pairs ||= dice.zip(values).map(&:freeze).freeze
    end

    def values
      @values ||= @rolls.map(&:value).freeze
    end

    def dice
      @dice ||= @rolls.map(&:die).freeze
    end

    def total
      @total ||= @rolls.sum(&:value)
    end
  end

  private_constant :Result
end
