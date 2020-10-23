# frozen_string_literal: true

module Dekorator
  require "dekorator/rails/controller"

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "dekorator/rails/tasks/dekorator.rake"
    end

    config.to_prepare do |_app|
      ActionController::Base.include Dekorator::Controller
    end
  end
end
