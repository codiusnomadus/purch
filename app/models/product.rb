class Product < ApplicationRecord
  self.table_name = 'core.products'
  resourcify
  include ImageUploader[:image]

  belongs_to :user, dependent: :destroy

  validates :name, :description, presence: true
end
