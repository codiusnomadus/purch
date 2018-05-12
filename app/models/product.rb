class Product < ApplicationRecord
  self.table_name = 'core.products'
  resourcify
  include UploadUploader[:image]


  belongs_to :user, dependent: :destroy

  has_many :uploads, as: :uploadable, dependent: :destroy
  accepts_nested_attributes_for :uploads, allow_destroy: true

   # validates_associated :uploads



  validates :name, :description, presence: true
end
