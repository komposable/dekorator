# frozen_string_literal: true

require "rails/generators"

module Rspec
  module Generators
    class DecoratorGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_decorator_spec
        template "decorator_spec.rb", File.join("spec/decorators", class_path, "#{file_name}_decorator_spec.rb")
      end
    end
  end
end
