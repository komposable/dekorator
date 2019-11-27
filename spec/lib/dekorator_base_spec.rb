# frozen_string_literal: true
#
require File.expand_path("../fixtures/models.rb", __dir__)
require File.expand_path("../fixtures/decorators.rb", __dir__)

RSpec.describe Dekorator::Base do
  let(:comment)        { Comment.new(author_name: "john.doe", body: "comment message") }
  let(:post)           { Post.new(name: "post title", body: "a" * 200, comments: [comment]) }
  let(:decorated_post) { PostDecorator.new(post) }
  let(:decorated_post_with_comments) { PostDecorator.new(post) }

  describe "self#decorate" do
    context "with empty object" do
      it { expect(described_class.decorate(nil)).to be_nil }
      it { expect(described_class.decorate([])).to be_empty }
    end

    context "with object" do
      it { expect(described_class.decorate(post)).to be_a(PostDecorator) }
      it { expect(PostDecorator.decorate(post)).to be_a(PostDecorator) }
    end

    context "with enumerable" do
      it { expect(described_class.decorate([post, post, post])).to all(be_a(PostDecorator)) }
      it { expect(PostDecorator.decorate([post, post, post])).to all(be_a(PostDecorator)) }
      it { expect(PostDecorator.decorate([post, post, post])).to be_a(Enumerable) }
    end

    context "with sepcified decorator class" do
      it { expect(described_class.decorate(post, with: AdvancedPostDecorator)).to be_a(AdvancedPostDecorator) }
      it { expect(PostDecorator.decorate(post, with: AdvancedPostDecorator)).to be_a(AdvancedPostDecorator) }
    end

    context "with ActiveRecord::Relation" do
      pending
    end

    context "with object without decorator" do
      let(:object) { ModelWithoutDecorator.new(name: "name") }

      it { expect { described_class.decorate(object) }.to raise_error(Dekorator::DecoratorNotFound) }
    end

    context "with block" do
      it { expect { |b| PostDecorator.decorate(post, &b) }.to yield_with_args(PostDecorator) }
    end

    context "with decorated object" do
      it { expect(described_class.decorate(decorated_post)).to be_a(PostDecorator) }
    end
  end

  describe "self#decorates_association" do
    it { expect(decorated_post_with_comments.comments).to all(be_a(CommentDecorator)) }
  end

  describe "self#base_class" do
    it { expect(PostDecorator.base_class).to be(Post) }
    it { expect(CommentDecorator.base_class).to be(Comment) }
  end

  describe "#object" do
    it { expect(decorated_post.object).to eq(post) }
  end
end
