# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  gem "rails", "6.0.1"
  gem "sqlite3"
  gem "benchmark-ips"
  gem "benchmark-memory"

  gem "dekorator", path: "../", require: false
  gem "draper", require: false
end

require "active_record"
require "logger"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = nil # Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
    t.string :title
    t.text :body
  end

  create_table :comments, force: true do |t|
    t.integer :post_id
    t.string :author
    t.text :body
  end
end

# Models
class Post < ActiveRecord::Base
  has_many :comments

  def summary
    @summary ||= body&.truncate(170)
  end
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

# Data
comments = 100.times.map { Comment.new(author: "John D.", body: "Great article") }
10.times.each { Post.create!(title: "Our first article!", body: "", comments: comments) }

# Decorators
require "dekorator"

class PostDecorator < Dekorator::Base
  decorates_association :comments

  def summary
    @summary ||= body&.truncate(170)
  end
end

class CommentDecorator < Dekorator::Base
end

require "draper"

class CommentDraperDecorator < Draper::Decorator
end

class PostDraperDecorator < Draper::Decorator
  decorates_association :comments, with: CommentDraperDecorator

  def summary
    @summary ||= object.body&.truncate(170)
  end
end

require "delegate"

class PostDelegator < SimpleDelegator
  def summary
    @summary ||= body&.truncate(170)
  end

  def comments
    @comments = __getobj__.comments.map { |comment| CommentDelegator.new(CommentDelegator) }
  end
end

class CommentDelegator < SimpleDelegator
end

# Benchmark
SCENARIOS = {
  "#summary"        => :summary,
  "#comments"       => :comments,
}

SCENARIOS.each_pair do |name, method|
  puts
  puts " #{name} ".center(80, "=")
  puts

  model = Post.all

  puts " ips ".center(80, "-")
  puts

  Benchmark.ips do |x|
    x.report("In model")  { model.first.public_send(method) }
    x.report("Dekorator") { PostDecorator.decorate(model).first.public_send(method) }
    x.report("Dekorator.new") { PostDecorator.decorate(model).first.public_send(method) }
    x.report("Draper") { PostDraperDecorator.decorate_collection(model).first.public_send(method) }
    x.report("SimpleDelegator") { PostDelegator.new(model.first).public_send(method) }

    x.compare!
  end

  puts " memory ".center(80, "-")
  puts

  Benchmark.memory do |x|
    x.report("In model")  { model.first.public_send(method) }
    x.report("Dekorator") { PostDecorator.decorate(model).first.public_send(method) }
    x.report("Dekorator.new") { PostDecorator.decorate(model).first.public_send(method) }
    x.report("Draper") { PostDraperDecorator.decorate_collection(model).first.public_send(method) }
    x.report("SimpleDelegator") { PostDelegator.new(model.first).public_send(method) }

    x.compare!
  end
end
