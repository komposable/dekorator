# Dekorator

An opinionated way of organizing model-view code in Ruby on Rails, based on decorators.

## Installation

Add this line to your application's Gemfile:

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

### Associations

If you want to automatically decorates association for a decorated object,
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
decorated_user = decorator(User.first)
decorated_user # => UserDecorator
decorated_user.posts.first # => PostDecorator
```

### Specify decorator

If you want to create specific decorator or sub-decorator, you could simply 
specify the decorator class that should be use.

```ruby
class AdminDecorator < ApplicationDecorator
end

decorated_user = decorator(User.first, with: AdminDecorator)
decorated_user # => AdminDecorator
```

You also could specify the decorator for associations:

```ruby
class UserDecorator < ApplicationDecorator
  decorates_association :posts, ArticleDecorator

  ...
end

class ArticleDecorator < ApplicationDecorator
end

decorated_user = decorator(User.first)
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

If you use [`device`][devise] gem you may have an issue if you decorate your
`User` model.

You must define `#devise_scope` as following. Devise need to manage with
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

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pantographe/dekorator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dekorator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pantographe/dekorator/blob/master/CODE_OF_CONDUCT.md).

[activeadmin]: https://activeadmin.info/11-decorators.html
[devise]: https://github.com/plataformatec/devise/
