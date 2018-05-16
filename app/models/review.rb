class Review < ApplicationRecord
  self.table_name = 'core.reviews'

  belongs_to :user, dependent: :destroy
  belongs_to :brand,
    primary_key: 'code',
    foreign_key: 'brand_code'

  has_many :uploads, as: :uploadable, dependent: :destroy
  accepts_nested_attributes_for :uploads, allow_destroy: true

  validates :title, :brand, :excerpt, :body, :verdict, presence: true
end
