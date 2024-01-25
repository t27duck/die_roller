# frozen_string_literal: true

require_relative "lib/die_roll/version"

Gem::Specification.new do |spec|
  spec.name = "die_roll"
  spec.version = DieRoll::VERSION
  spec.authors = ["Tony Drake"]
  spec.email = ["t27duck@gmail.com"]

  spec.summary = "A simple dice notation parser and roller."
  spec.description = "A simple dice notation parser and roller."
  spec.homepage = "https://github.com/t27duck/die_roll"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
