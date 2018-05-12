class Review < ApplicationRecord
  belongs_to :user

  validates :title, :body, :verdict, presence: true
end
