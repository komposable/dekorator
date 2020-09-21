# frozen_string_literal: true

SimpleCov.minimum_coverage 70 # TODO: should be 90

SimpleCov.start do
  add_filter "/spec/"
end
