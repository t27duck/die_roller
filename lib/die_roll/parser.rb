# frozen_string_literal: true

module DieRoll
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
end
