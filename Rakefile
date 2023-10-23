# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rspec/core/rake_task"

namespace :test do
  task all: %i[rubocop spec]

  RuboCop::RakeTask.new

  RSpec::Core::RakeTask.new(:spec)

end

task test: :"test:all"

task default: :test
