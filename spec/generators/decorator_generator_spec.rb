# frozen_string_literal: true

RSpec.describe "decorator", type: :generator do
  before { with_app { generate("dekorator:install") } }

  it "generates a Decorator file for a simple Object" do
    generate("decorator User")

    expect("app/decorators/user_decorator.rb").to match_contents(%r{UserDecorator})
  end

  it "generates a Decorator file for a namespaced Object" do
    generate("decorator Product::Attribute")

    expect("app/decorators/product/attribute_decorator.rb").to match_contents(%r{Product::AttributeDecorator})
  end
end
