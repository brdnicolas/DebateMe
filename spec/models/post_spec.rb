require 'rails_helper'

RSpec.describe Post, type: :model do
  # Association test
  it { should belong_to(:user)}
  # Validation tests
  it { should validate_presence_of(:content) }
end