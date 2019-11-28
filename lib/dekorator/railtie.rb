# frozen_string_literal: true

module Dekorator
  require "dekorator/rails/controller"

  class Railtie < ::Rails::Railtie
    config.to_prepare do |_app|
      ActionController::Base.include Dekorator::Controller
    end

    config.after_initialize do |app|
      app.config.paths.add "app/decorators", eager_load: true
    end
  end
end
