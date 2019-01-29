# frozen_string_literal: true

module DecoratorsHelper
  delegate :decorate, to: "Dekorator::Base"
end
