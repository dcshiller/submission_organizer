class User < ApplicationRecord
  has_secure_password

  has_many :articles

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def to_s
    name
  end
end
