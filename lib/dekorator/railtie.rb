# frozen_string_literal: true

module Dekorator
  require "dekorator/rails/controller"

  class Railtie < ::Rails::Railtie
    config.to_prepare do |_app|
      ActionController::Base.include Dekorator::Controller
    end
  end
end
