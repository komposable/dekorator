# frozen_string_literal: true

module Dekorator
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def create_root_directory
        return if File.directory?(dekorator_root_directory)

        empty_directory(dekorator_root_directory)
      end

      def create_application_decorator
        return if File.exist?(application_decorator_path)

        create_file application_decorator_path, <<-RUBY
# frozen_string_literal: true

class ApplicationDecorator < Dekorator::Base
end
        RUBY
      end

      protected

      def dekorator_root_directory
        Rails.root.join("app", "decorators")
      end

      def application_decorator_path
        dekorator_root_directory.join("application_decorator.rb")
      end
    end
  end
end
