# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rspec/core/rake_task"
require "coveralls/rake/task"

namespace :test do
  task all: %i[rubocop spec]
  task all_with_coverage: %i[all coveralls:push]

  RuboCop::RakeTask.new

  RSpec::Core::RakeTask.new(:spec)

  Coveralls::RakeTask.new
end

task test: :"test:all"

task default: :test
