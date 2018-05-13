class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products
  has_many :reviews

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:subscriber) if self.roles.blank?
  end
end
