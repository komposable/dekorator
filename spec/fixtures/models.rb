# frozen_string_literal: true

require "active_model"

class ModelWithoutDecorator
  include ActiveModel::Model
  attr_accessor :name
end

class User
  include ActiveModel::Model
  attr_accessor :posts
  attr_accessor :comments
  attr_accessor :first_name, :last_name, :email
end

class Post
  include ActiveModel::Model
  attr_accessor :user
  attr_accessor :comments
  attr_accessor :name, :body
end

class Comment
  include ActiveModel::Model
  attr_accessor :user
  attr_accessor :post
  attr_accessor :author_name, :body
end
