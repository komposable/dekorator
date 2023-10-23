# frozen_string_literal: true

require "simplecov"

SimpleCov.minimum_coverage 70 # TODO: should be 90

SimpleCov.start do
  add_filter "/spec/"

  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
  ])
end
