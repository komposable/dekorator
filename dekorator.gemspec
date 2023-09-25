# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dekorator/version"

Gem::Specification.new do |spec|
  spec.name        = "dekorator"
  spec.version     = Dekorator::VERSION
  spec.authors     = ["Pantographe"]
  spec.email       = ["oss@pantographe.studio"]

  spec.summary     = "An opinionated way of organizing model-view code in Ruby on Rails, based on decorators"
  spec.description = "An opinionated way of organizing model-view code in Ruby on Rails, based on decorators"
  spec.homepage    = "http://komponent.io"
  spec.license     = "MIT"

  spec.metadata    = {
    "homepage_uri" => spec.homepage,
    "changelog_uri"   => "https://github.com/komposable/dekorator/blob/main/CHANGELOG.md",
    "source_code_uri" => "https://github.com/komposable/dekorator",
    "bug_tracker_uri" => "https://github.com/komposable/dekorator/issues",
}

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files       = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0")
      .reject do |f|
        f.match(%r{^(test|spec|features|gemfiles|bin)/}) \
        || %w[.editorconfig .gitignore .inch.yml .rspec .rubocop.yml .simplecov .travis.yml
          .yardots Appraisals Gemfile Gemfile.lock].include?(f)
      end
  end

  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_runtime_dependency "actionview", ">= 5.2", "< 7.1"
  spec.add_runtime_dependency "activerecord", ">= 5.2", "< 7.1"
  spec.add_runtime_dependency "activesupport", ">= 5.2", "< 7.1"
  spec.add_runtime_dependency "railties", ">= 5.2", "< 7.1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
