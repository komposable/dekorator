# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in dekorator.gemspec
gemspec

gem "activerecord", ">= 5.0", "< 6.1", require: false
gem "activemodel", ">= 5.0", "< 6.1", require: false
gem "activesupport", ">= 5.0", "< 6.1", require: false
gem "actionview", ">= 5.0", "< 6.1", require: false
gem "railties", ">= 5.0", "< 6.1", require: false

gem "appraisal", require: false
gem "rubocop", require: false

group :test do
  gem "simplecov", require: false
  gem 'coveralls', require: false
end
