# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password

  has_many :articles, dependent: :destroy
  has_many :submissions, through: :articles
  has_many :events, through: :submissions, class_name: "SubmissionEvent"

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password_digest, presence: true

  def to_s
    name
  end
end
