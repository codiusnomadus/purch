class Brand < ApplicationRecord
  self.table_name = 'reference.brands'
  self.primary_key = 'code'

  has_many :products,
    primary_key: 'code',
    foreign_key: 'brand_code'

  has_many :reviews,
    primary_key: 'code',
    foreign_key: 'brand_code'

  has_many :deals,
    primary_key: 'code',
    foreign_key: 'brand_code'

  validates :name, :code, presence: true

  def to_s
    name
  end

end
