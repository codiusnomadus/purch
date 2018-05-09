require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "associations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe "validations" do

  end
end
