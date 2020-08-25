require 'rails_helper'

RSpec.describe Question, type: :model do
  # Association test
  it { should belong_to(:theme)}
  # Validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
end

