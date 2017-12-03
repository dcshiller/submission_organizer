class Journal < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  
  def to_s
    title
  end
end
