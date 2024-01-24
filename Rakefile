# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create

require "rubocop/rake_task"

RuboCop::RakeTask.new

require "steep"
require "steep/cli"

desc "Type check with Steep"
task :steep do
  Steep::CLI.new(argv: ["check"], stdout: $stdout, stderr: $stderr, stdin: $stdin).run
end

task default: %i[test rubocop steep]
