# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in dekorator.gemspec
gemspec

gem "activerecord"
gem "activemodel"
gem "activesupport"
gem "actionview"
gem "railties"

gem "appraisal", require: false
gem "rubocop", require: false

group :test do
  gem "simplecov", require: false
  gem 'coveralls', require: false
end
