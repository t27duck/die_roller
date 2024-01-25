# frozen_string_literal: true

require_relative "die_roller/version"
require_relative "die_roller/parser"
require_relative "die_roller/result"
require_relative "die_roller/roll"
require_relative "die_roller/roller"

# A simple parser to roll one or more dice.
#   DieRoller.roll("input")
#
#   Example valid inputs:
#     "1d6"
#     "d6" # Defaults to 1 die
#     "2d8" # 2 8-sided dice
#     "1d6 2d4" # 1 6-sided die and 2 4-sided dice
#     "2D100"
#
#   Multiple dice can be separated with whitespace:
#     "1d6 1d8"
#
#   `.roll` returns a `DieRoller::Result` object with info regarding the roll(s).
module DieRoller
  DICE_SYNTAX_REGEX = /\A\d*d\d+\z/
  MINIMUM_DIE_SIZE = 4

  class ParseError < StandardError; end
  class DieSizeError < StandardError; end

  def self.roll(input)
    parser = Parser.new(input)
    rolls = Roller.roll(parser)
    Result.new(rolls: rolls, tokens: parser.tokens)
  end
end
