# frozen_string_literal: true

require "active_support/concern"

module Dekorator
  module Record
    def decorated
      @decorated ||= Dekorator::Base.decorate(self)
    end
  end
end
