# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dekorator/version"

Gem::Specification.new do |spec|
  spec.name          = "dekorator"
  spec.version       = Dekorator::VERSION
  spec.authors       = ["Nicolas Brousse"]
  spec.email         = ["nicolas@pantographe.studio"]

  spec.summary       = "An opinionated way of organizing model-view code in Ruby on Rails, based on decorators"
  spec.description   = "An opinionated way of organizing model-view code in Ruby on Rails, based on decorators"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0")
      .reject do |f|
        f.match(%r{^(test|spec|features|gemfiles|bin)/}) \
        || %w[.editorconfig .gitignore .inch.yml .rspec .rubocop.yml .simplecov .travis.yml
          .yardots Appraisals Gemfile Gemfile.lock].include?(f)
      end
  end

  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
