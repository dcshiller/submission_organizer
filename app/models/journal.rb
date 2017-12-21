class Journal < ApplicationRecord
  validates :title, uniqueness: true, presence: true

  has_many :submissions

  def to_s
    title
  end

  def last_activity_for(user)
    SubmissionEvent.where(submission: user.submissions.where(journal: self)).order(date: :desc)&.first&.date
  end
end
