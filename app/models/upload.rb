class Upload < ApplicationRecord
  self.table_name = 'core.uploads'
  include UploadUploader[:upload]

  belongs_to :uploadable, polymorphic: true, optional: true

  # validates :upload, presence: true
end
