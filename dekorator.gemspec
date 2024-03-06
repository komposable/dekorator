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
  spec.homepage    = "https://github.com/komposable/dekorator"
  spec.license     = "MIT"

  spec.metadata    = {
    "homepage_uri" => spec.homepage,
    "changelog_uri"   => "https://github.com/komposable/dekorator/blob/main/CHANGELOG.md",
    "source_code_uri" => spec.homepage,
    "bug_tracker_uri" => "https://github.com/komposable/dekorator/issues",
    "rubygems_mfa_required" => "true"
}

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.add_runtime_dependency "actionview", ">= 6.1", "< 7.2"
  spec.add_runtime_dependency "activerecord", ">= 6.1", "< 7.2"
  spec.add_runtime_dependency "activesupport", ">= 6.1", "< 7.2"
end
