# frozen_string_literal: true

require "active_support/core_ext/module/delegation"
require "dekorator/decorators_helper"

require File.expand_path("../fixtures/models.rb", __dir__)
require File.expand_path("../fixtures/decorators.rb", __dir__)

RSpec.describe DecoratorsHelper do
  let(:comment) { Comment.new(author_name: "john.doe", body: "comment message") }
  let(:post)    { Post.new(name: "post title", body: "a" * 200, comments: [comment]) }

  describe "#decorate" do
    context "with object" do
      it { expect(described_class.decorate(post)).to be_a(PostDecorator) }
      it { expect(described_class.decorate(post)).to be_a(PostDecorator) }
    end

    context "with enumerable" do
      it { expect(described_class.decorate([post, post, post])).to all(be_a(PostDecorator)) }
      it { expect(described_class.decorate([post, post, post])).to all(be_a(PostDecorator)) }
      it { expect(described_class.decorate([post, post, post])).to be_a(Enumerable) }
    end
  end
end
