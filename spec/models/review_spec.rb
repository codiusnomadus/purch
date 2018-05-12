require 'rails_helper'

RSpec.describe Review, type: :model do

  # Associations - belongs_to
  it { should belong_to(:user) }

  # Associations - has_many
  it { should have_many(:pros) }
  it { should have_many(:cons) }

  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:verdict) }
end
