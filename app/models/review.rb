class Review < ApplicationRecord
  self.table_name = 'core.reviews'

  belongs_to :user, dependent: :destroy

  has_many :uploads, as: :uploadable, dependent: :destroy
  accepts_nested_attributes_for :uploads, allow_destroy: true

  validates :title, :excerpt, :body, :verdict, presence: true
end
