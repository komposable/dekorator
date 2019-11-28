# Dekorator

[![Tests](https://github.com/komposable/dekorator/workflows/Tests/badge.svg)](https://github.com/komposable/dekorator/actions)
[![Gem Version](https://badge.fury.io/rb/dekorator.svg)](https://rubygems.org/gems/dekorator)
[![Maintainability](https://api.codeclimate.com/v1/badges/f7ab08512ead00da34c0/maintainability)](https://codeclimate.com/github/komposable/dekorator/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/komposable/dekorator/badge.svg)](https://coveralls.io/github/komposable/dekorator)
[![Inch CI](https://inch-ci.org/github/komposable/dekorator.svg?branch=master)](https://inch-ci.org/github/komposable/dekorator)
[![Yardoc](https://img.shields.io/badge/doc-yardoc-blue.svg)](https://www.rubydoc.info/github/komposable/dekorator/master)

**Dekorator** is a lightweight library to implement _presenters_ and/or _decorators_ in your Rails app. It has less features than [`draper`](https://github.com/drapergem/draper) and aims at having a lower memory footprint.

**Not production ready yet**

This gem has been inspired by our Rails development practices at [Pantographe](https://pantographe.studio), and the [Ruby memory, ActiveRecord and Draper](https://medium.com/appaloosa-store-engineering/ruby-memory-activerecord-and-draper-64f06abeeb34) talk by [Benoit Tigeot](https://github.com/benoittgt).

## Compatibility

* Ruby 2.4+
* Rails 5.0+

## Installation

Add this line to your application `Gemfile`:

```ruby
gem "dekorator"
```

And then execute:

    $ bundle

## Getting started

Run the following command to set up your project:

    $ rails generate dekorator:install

This command will create an `ApplicationDecorator` file.

## Usage

Generate a new decorator with the `decorator` generator:

    $ rails generate decorator user

This command will generate the following file:

```ruby
class UserDecorator < ApplicationDecorator
  # include ActionView::Helpers::TextHelper
  #
  # decorates_association :posts
  #
  # def full_name
  #   [first_name, last_name].join(" ")
  # end
  #
  # def biography_summary
  #   truncate(biography, length: 170)
  # end
end
```

In a view or a controller, simply do:

```ruby
@users = decorate(User.all)
# or
@user = decorate(User.find(params[:id]))
```

### Associations

If you want to automatically decorate an association for a decorated object,
you have to use `#decorates_association` as following:

```ruby
class UserDecorator < ApplicationDecorator
  decorates_association :posts

  ...
end

class PostDecorator < ApplicationDecorator
  ...
end
```

In this example, `UserDecorator#posts` will be decorated.

```ruby
decorated_user = decorate(User.first)
decorated_user # => UserDecorator
decorated_user.posts.first # => PostDecorator
```

### Specify decorator

If you want to create a specific decorator or sub-decorator, you can simply
specify the decorator class that should be used.

```ruby
class AdminDecorator < ApplicationDecorator
  ...
end

decorated_user = decorate(User.first, with: AdminDecorator)
decorated_user # => AdminDecorator
```

You can also specify the decorator for associations:

```ruby
class UserDecorator < ApplicationDecorator
  decorates_association :posts, ArticleDecorator

  ...
end

class ArticleDecorator < ApplicationDecorator
end

decorated_user = decorate(User.first)
decorated_user # => UserDecorator
decorated_user.posts.first # => ArticleDecorator
```

## Compatibility

### ActiveAdmin

This gem is compatible with [`activeadmin`][activeadmin].

Simply use `#decorate_with`

```ruby
# app/admin/post.rb
ActiveAdmin.register Post do
  decorate_with PostDecorator

  index do
    column :title
    column :image
    actions
  end
end
```

### Devise

If you use the [`Devise`][devise] gem you may have an issue if you decorate your
`User` model.

You must define `#devise_scope` as following. Devise needs to manage with the
`User` model (https://github.com/plataformatec/devise/blob/369ba267efaa10d01c8dba59b09c3b94dd9e5551/lib/devise/mapping.rb#L35).

```ruby
class UserDecorator < ApplicationDecorator
  ...

  def devise_scope
    __getobj__
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org].

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/komposable/dekorator. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License].

## Code of Conduct

Everyone interacting in the Dekorator project codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct].

[activeadmin]: https://activeadmin.info/11-decorators.html
[devise]: https://github.com/plataformatec/devise/
[rubygems.org]: https://rubygems.org
[MIT License]: https://opensource.org/licenses/MIT
[code of conduct]: https://github.com/komposable/dekorator/blob/master/CODE_OF_CONDUCT.md
