class Product < ApplicationRecord
  self.table_name = 'core.products'
  resourcify

  belongs_to :user, dependent: :destroy
  belongs_to :brand,
    primary_key: 'code',
    foreign_key: 'brand_code'

  has_many :uploads, as: :uploadable, dependent: :destroy
  accepts_nested_attributes_for :uploads, allow_destroy: true

  validates :name, :brand, :description, presence: true
end
