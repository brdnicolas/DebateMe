require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:posts).dependent(:destroy)}
  # Validation tests
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }
end
