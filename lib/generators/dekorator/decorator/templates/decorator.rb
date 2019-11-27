# frozen_string_literal: true

<% module_namespacing do -%>
class <%= class_name %>Decorator < ApplicationDecorator
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
<% end -%>
