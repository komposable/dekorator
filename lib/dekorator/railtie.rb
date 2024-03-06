# frozen_string_literal: true

module Dekorator
  require "dekorator/rails/controller"
  require "dekorator/rails/record"

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "dekorator/rails/tasks/dekorator.rake"
    end

    config.to_prepare do |_app|
      ActionController::Base.include Dekorator::Controller
      ActiveRecord::Base.include Dekorator::Record
    end
  end
end
