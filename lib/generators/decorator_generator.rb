# frozen_string_literal: true

require "rails/generators"

class DecoratorGenerator < ::Rails::Generators::NamedBase
  invoke "dekorator:decorator"
end
