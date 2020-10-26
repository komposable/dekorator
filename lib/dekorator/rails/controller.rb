# frozen_string_literal: true

require "active_support/concern"

module Dekorator
  module Controller
    extend ActiveSupport::Concern

    included do
      helper_method :decorate
    end

    def decorate(object_or_enumerable, with: nil)
      Dekorator::Base.decorate(object_or_enumerable, with: with)
    end
  end
end
