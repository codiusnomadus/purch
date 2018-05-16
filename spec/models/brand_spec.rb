require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe "associations" do
    it { should have_many(:deals) }
    it { should have_many(:products) }
    it { should have_many(:reviews) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
  end
end
