# frozen_string_literal: true

require "rails/generators"

module Dekorator
  module Generators
    class DecoratorGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_decorator
        template "decorator.rb", File.join("app/decorators", class_path, "#{file_name}_decorator.rb")
      end

      hook_for :test_framework
    end
  end
end
