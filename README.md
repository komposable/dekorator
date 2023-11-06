# Dekorator

[![Tests](https://github.com/komposable/dekorator/workflows/Tests/badge.svg)](https://github.com/komposable/dekorator/actions)
[![Gem Version](https://badge.fury.io/rb/dekorator.svg)](https://rubygems.org/gems/dekorator)
[![Maintainability](https://api.codeclimate.com/v1/badges/f7ab08512ead00da34c0/maintainability)](https://codeclimate.com/github/komposable/dekorator/maintainability)
[![Inch CI](https://inch-ci.org/github/komposable/dekorator.svg?branch=main)](https://inch-ci.org/github/komposable/dekorator)
[![Yardoc](https://img.shields.io/badge/doc-yardoc-blue.svg)](https://www.rubydoc.info/github/komposable/dekorator/main)

**Dekorator** is a lightweight library to implement _presenters_ and/or _decorators_ in your Rails app. It has less features than [`draper`](https://github.com/drapergem/draper) and aims at having a lower memory footprint.

This gem has been inspired by our Rails development practices at [Pantographe](https://pantographe.studio), and the [Ruby memory, ActiveRecord and Draper](https://medium.com/appaloosa-store-engineering/ruby-memory-activerecord-and-draper-64f06abeeb34) talk by [Benoit Tigeot](https://github.com/benoittgt).

## Compatibility

* Ruby 2.7+
* Rails 6.0+

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
  include ActionView::Helpers::TextHelper

  decorates_association :posts

  def full_name
    [first_name, last_name].join(" ")
  end

  def biography_summary
    truncate(biography, length: 170)
  end
end
```

### Decorate from a controller

```ruby
class UsersController < ApplicationController
  def index
    @users = decorate User.all
  end

  def show
    @user = decorate User.find(params[:id])
  end
end
```

### Decorate from a view

```erb
# app/views/users/index.html.erb

<ul>
  <% decorate(@users).each do |user| %>
    <li><%= user.full_name %></li>
  <% end %>
</ul>
```

### Decorate outside a controller/view

```ruby
UserDecorate.decorate(User.first) # => UserDecorator
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

In this example, `UserDecorator#posts` will be decorated as `#decorated_posts`.

```ruby
decorated_user = decorate(User.first)
decorated_user # => UserDecorator
decorated_user.decorated_posts.first # => PostDecorator
```

### Custom decorator

By default, Dekorator searches for the decorator class by adding `Decorator` at the end.
For `User`, Dekorator looks for the `UserDecorator` class, and for `User::Profile`
it looks for `User::ProfileDecorator`.

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
  decorates_association :posts, with: ArticleDecorator

  ...
end

class ArticleDecorator < ApplicationDecorator
end

decorated_user = decorate(User.first)
decorated_user # => UserDecorator
decorated_user.decorated_posts.first # => ArticleDecorator
```

## Compatibility

### ActiveAdmin

This gem is compatible with [`activeadmin`][activeadmin] ([2.8+](https://github.com/activeadmin/activeadmin/pull/6249)).
For `activeadmin` before `2.8`, use `dekorator` `1.0.*`.

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

## Testing

`rails generate decorator user` also generates a testing file based on your
configuration.

You can test a decorator the same way you do for helpers.

### RSpec

```ruby
describe UserDecorator, type: :decorator do
  let(:object) { User.new(first_name: "John", last_name: "Doe") }
  let(:decorated_user) { described_class.new(object) }

  describe "#full_name" do
    it { expect(decorated_user.full_name).to eq("John Doe") }
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
[code of conduct]: https://github.com/komposable/dekorator/blob/main/CODE_OF_CONDUCT.md
