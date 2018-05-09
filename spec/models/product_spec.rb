require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    create(:user)
    create(:product)
  end

  describe "associations" do
    it { should belong_to(:user).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end
end
