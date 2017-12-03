class Article < ApplicationRecord
  belongs_to :user
  has_many :submissions
  
  def to_s
    title
  end
end
