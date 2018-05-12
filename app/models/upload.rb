class Upload < ApplicationRecord
  include UploadUploader[:upload]

  belongs_to :uploadable, polymorphic: true, optional: true

  # validates :upload, presence: true
end
