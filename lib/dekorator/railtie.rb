# frozen_string_literal: true

require "dekorator/decorators_helper"

module Dekorator
  class Railtie < Rails::Railtie
    initializer "decorators.helper" do |_app|
      ActionView::Base.send :include, Dekorator::DecoratorsHelper
      ActionController::Base.send :include, Dekorator::DecoratorsHelper
    end

    config.after_initialize do |app|
      app.config.paths.add "app/decorators", eager_load: true
    end
  end
end
