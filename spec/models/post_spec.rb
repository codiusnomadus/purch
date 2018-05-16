require 'rails_helper'

RSpec.describe Post, type: :model do
  # Associations - belongs_to
  it { should belong_to(:user) }
  it { should belong_to(:category) }

  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:excerpt) }
end
