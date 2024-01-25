# frozen_string_literal: true

module DieRoller
  # Responsible for rolling dice given `tokens` from a `DieRoller::Parser`.
  class Roller
    def self.roll(parser)
      parser.tokens.map do |token|
        numbers = token.split("d")
        sides = numbers[1].to_i

        raise DieSizeError, "Die size too small for '#{token}'" if sides < MINIMUM_DIE_SIZE

        die_count = numbers[0].to_i
        die_count = 1 if die_count.zero?
        Array.new(die_count) { Roll.new(sides: sides, value: rand(sides) + 1) }
      end.flatten
    end
  end

  private_constant :Roller
end
