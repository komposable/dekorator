# frozen_string_literal: true

require '<%= File.exist?("spec/rails_helper.rb") ? "rails_helper" : "spec_helper" %>'

# Example:
#
# describe <%= class_name %>Decorator, type: :decorator do
#   let(:object) { User.new(first_name: "John", last_name: "Doe") }
#   let(:decorated_user) { described_class.new(object) }
#
#   describe "#full_name" do
#     it { expect(decorated_user.full_name).to eq("John Doe") }
#   end
# end
RSpec.describe <%= class_name %>Decorator, type: :decorator do
  pending "add some examples to (or delete) #{__FILE__}"
end
