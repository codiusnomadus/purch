class Post < ApplicationRecord
  self.table_name = 'core.posts'

  belongs_to :user
  belongs_to :category

  has_many :uploads, as: :uploadable, dependent: :destroy
  accepts_nested_attributes_for :uploads, allow_destroy: true

  validates :title, :excerpt, :body, presence: true
end
