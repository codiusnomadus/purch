class Review < ApplicationRecord
  include UploadUploader[:image]


  belongs_to :user
  validates :title, :body, :verdict, presence: true
end
