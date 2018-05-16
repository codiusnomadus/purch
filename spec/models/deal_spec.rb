require 'rails_helper'

RSpec.describe Deal, type: :model do
  before do
    create(:brand)
  end

  describe "associations" do
    it { should belong_to(:user).dependent(:destroy) }
    it { should belong_to(:brand) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:brand) }
  end
end
