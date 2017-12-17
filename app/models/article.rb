class Article < ApplicationRecord
  belongs_to :user
  has_many :submissions
  has_many :submission_events, through: :submissions, source: :events
  has_many :journals, through: :submissions
  
  def to_s
    title
  end
end
