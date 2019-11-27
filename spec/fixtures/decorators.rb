# frozen_string_literal: true

require "digest/md5"

class UserDecorator < Dekorator::Base
  decorates_association :posts
  decorates_association :comments

  def full_name
    [first_name, last_name].join(" ")
  end

  def gravatar_image_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end
end

class PostDecorator < Dekorator::Base
  decorates_association :user
  decorates_association :comments
end

class AdvancedPostDecorator < PostDecorator; end

class CommentDecorator < Dekorator::Base
  decorates_association :user
  decorates_association :post
end
