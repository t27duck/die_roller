# frozen_string_literal: true

require_relative "die_roll/version"

# A simple parser to roll one or more dice.
#   DieRoll.roll("input")
#
#   Example valid inputs:
#     "1d6"
#     "d6" # Defaults to 1 die
#     "2d8" # 2 8-sided dice
#     "1d6 2d4" # 1 6-sided die and 2 4-sided dice
#     "2D100"
#
#   Multiple dice can be separated with whitespace and/or `+`'s
#     "1d6 1d8" is the same as...
#     "1d6 + 1d8" is the same as...
#     "1d6+1d8"
#
#   `.roll` returns a `DieRoll::Result` object with info regarding the roll(s).
module DieRoll
  DICE_SYNTAX_REGEX = /\A\d*d\d+\z/
  MINIMUM_DIE_SIZE = 4

  class ParseError < StandardError; end
  class DieSizeError < StandardError; end

  def self.roll(input)
    parser = Parser.new(input)
    rolls = Roller.roll(parser)
    Result.new(rolls: rolls, tokens: parser.tokens)
  end

  # Responsible for rolling dice given `tokens` from a `DieRoll::Parser`.
  class Roller
    def self.roll(parser)
      parser.tokens.map do |token|
        numbers = token.split("d")
        sides = numbers[1].to_i

        raise DieSizeError, "Die size too small for '#{token}'" if sides < MINIMUM_DIE_SIZE

        die_count = numbers[0].to_i
        die_count = 1 if die_count.zero?
        Roll.new(sides: sides, values: Array.new(die_count) { rand(sides) + 1 })
      end
    end
  end

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

  # Accpets a string input, and parses it for die tokens.
  class Parser
    attr_reader :tokens

    def initialize(input)
      generate_tokens(input)
      validate_tokens
    end

    private

    def generate_tokens(input)
      @tokens = input.split.map { |t| t.to_s.split("+") }.flatten.reject { |t| t == "" || t.nil? }.map(&:downcase)
    end

    def validate_tokens
      @tokens.each do |token|
        raise ParseError, "Invalid input '#{token}'" unless token.match?(DICE_SYNTAX_REGEX)
      end
    end
  end

  private_constant :Parser
  private_constant :Result
  private_constant :Roll
  private_constant :Roller
end
