# frozen_string_literal: true

require_relative "die_roll/version"

# A simple parser to roll one or more dice.
#   DieRoll.roll("input")
#
#   Example inputs:
#     "1d6"
#     "d6" # Defaults to 1 die
#     "2d8" # 2 8-sided dice
#     "1d6 2d4" # 1 6-sided die and 2 4-sided dice
#
#   Multiple dice can be separated with whitespace and/or `+`'s
#     "1d6 1d8" is the same as...
#     "1d6 + 1d8" is the same as...
#     "1d6+1d8"
#
#   `.roll` returns a `DieRoll::Result` object with info regarding the roll(s).
module DieRoll
  class Error < StandardError; end

  def self.roll(input)
    parser = Parser.new(input)
    rolls = Roller.roll(parser)
    Result.new(rolls: rolls, tokens: parser.tokens)
  end

  # Responsible for rolling dice given `tokens` from a `DieRoll::Parser`.
  class Roller
    def self.roll(parser)
      parser.tokens.map do |token|
        die_count, sides = token.split("d").map(&:to_i)
        die_count = 1 if die_count.zero?
        Roll.new(sides: sides, values: Array.new(die_count) { rand(sides) + 1 })
      end
    end
  end

  # Holds the final result of rolls.
  class Result
    attr_reader :tokens

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
    D_SYNTAX_REGEX = /\A\d*d\d+\z/

    attr_reader :tokens

    def initialize(input)
      generate_tokens(input)
      validate_tokens
    end

    private

    def generate_tokens(input)
      @tokens = input.split.map! { |token| token.split("+") }.flatten!
    end

    def validate_tokens
      @tokens.each do |token|
        raise Error, "Invalid input '#{token}'" unless token.match?(D_SYNTAX_REGEX)
      end
    end
  end
end
