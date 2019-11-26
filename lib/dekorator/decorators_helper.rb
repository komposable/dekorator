# frozen_string_literal: true

module DecoratorsHelper
  def decorate(object_or_collection, with: nil)
    Dekorator::Base.decorate(object_or_collection, with: with)
  end
end
