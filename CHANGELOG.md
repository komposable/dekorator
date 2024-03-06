# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Add Ruby 3.3 support ([#53](https://github.com/komposable/dekorator/pull/53))
### Removed
- Drop Ruby 2.7 support ([#53](https://github.com/komposable/dekorator/pull/53))
- Drop Rails 6.0 support ([#53](https://github.com/komposable/dekorator/pull/53))

## [1.4.0] - 2023-11-09
### Changed
- ⚠️ **Breaking** `.decorates_association` now generate `#decorated_[ASSOCIATION_NAME]` instead `#[ASSOCIATION_NAME]` ([#48](https://github.com/komposable/dekorator/pull/48))

## [1.3.0] - 2023-11-06
### Added
- Add Rails 7.1 support ([#49](https://github.com/komposable/dekorator/pull/49))
### Fixes
- Fix RSpec `decorator_spec.rb` template by using `File#exist?` instead `File#exists?` ([#51](https://github.com/komposable/dekorator/pull/51))
### Removed
- Add Rails 7.0 on CI tests via Appraisals ([#47](https://github.com/komposable/dekorator/pull/47))
- Drop Ruby 2.5 and 2.6 support ([#47](https://github.com/komposable/dekorator/pull/47))
- Remove Coveralls usage ([#47](https://github.com/komposable/dekorator/pull/47))

## [1.2.1] - 2021-10-14
### Changed
- Make decorated `Enumerable` not lazy anymore ([#46](https://github.com/komposable/dekorator/pull/46))

## [1.2.0] - 2021-10-14
### Added
- Add Rails 7.0 support ([#43](https://github.com/komposable/dekorator/pull/43))
### Fixes
- Avoid n+1 queries when decorate ActiveRecord::Relation ([#44](https://github.com/komposable/dekorator/pull/44))

## [1.1.0] - 2020-12-23
### Added
- Ruby 2.7 support ([#37](https://github.com/komposable/dekorator/pull/37))
- List decorators in Rails stats task ([#38](https://github.com/komposable/dekorator/pull/38))
- Add Rails 6.1 support and drop Rails 5.0 and 5.1 support ([#41](https://github.com/komposable/dekorator/pull/41))
### Changed
- Refactorisation ([#39](https://github.com/komposable/dekorator/pull/39))
### Removed
- Remove `DecoratedEnumerableProxy` ([#36](https://github.com/komposable/dekorator/pull/36))
- Drop Ruby 2.4 support ([#37](https://github.com/komposable/dekorator/pull/37))
- Drop Rails 5.0 and 5.1 support ([#41](https://github.com/komposable/dekorator/pull/41))

## [1.0.0] - 2019-12-02
### Added
- Avoid deep decoration ([#25](https://github.com/komposable/dekorator/pull/25))
- Make `decorate` accessible in ApplicationController ([#29](https://github.com/komposable/dekorator/pull/29))

### Changed
- Moved to Komposable organization ([#13](https://github.com/komposable/dekorator/pull/13))
- Replace Travis CI by Github Actions and remove ruby 2.3 support ([#23](https://github.com/komposable/dekorator/pull/23))
- Update railtie to prevent triggering initialization autoloaded constant deprecation warning ([#30](https://github.com/komposable/dekorator/pull/30))
- Improve generators ([#31](https://github.com/komposable/dekorator/pull/31))

### Fixes
- Fix DecoratedEnumerableProxy for Rails 6 ([5a656333](https://github.com/komposable/dekorator/commit/5a656333e9ca6321d0474f0e54de4332219b88d0))

## 1.0.0.pre.1 - 2019-01-30
### Added
- Create Dekorator::Base the base of decorators ([a2a36d66](https://github.com/komposable/dekorator/commit/a2a36d66c6de6cb0a00f783794cd29f899bc04b6))
- Create `dekorator:install` generator ([a2a36d66](https://github.com/komposable/dekorator/commit/a2a36d66c6de6cb0a00f783794cd29f899bc04b6))
- Create `decorator` generator ([a2a36d66](https://github.com/komposable/dekorator/commit/a2a36d66c6de6cb0a00f783794cd29f899bc04b6))

[Unreleased]: https://github.com/komposable/dekorator/compare/v1.4.0...main
[1.4.0]: https://github.com/komposable/dekorator/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/komposable/dekorator/compare/v1.2.1...v1.3.0
[1.2.1]: https://github.com/komposable/dekorator/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/komposable/dekorator/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/komposable/dekorator/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/komposable/dekorator/compare/v1.0.0.pre.1...v1.0.0
