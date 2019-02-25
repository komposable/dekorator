# frozen_string_literal: true

RSpec.describe "dekorator:install", type: :generator do
  it "creates ApplicationDecorator file" do
    with_app { generate("dekorator:install") }

    expect("app/decorators/application_decorator.rb").to match_contents(%r{ApplicationDecorator})
  end
end
