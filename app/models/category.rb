class Category < ApplicationRecord
  self.table_name = 'reference.categories'

  belongs_to :user
  has_many :posts

  validates :name, presence: true
end
