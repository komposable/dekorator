# frozen_string_literal: true

require "dekorator/decorators_helper"

module Dekorator
  class Railtie < Rails::Railtie
    initializer "decorators.helper" do |_app|
      ActionView::Base.send :include, DecoratorsHelper
    end
  end
end
