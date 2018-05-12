require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    create(:user)
  end

  describe "associations" do
    it { should have_many(:products) }
  end

  describe "validations" do

  end
end
