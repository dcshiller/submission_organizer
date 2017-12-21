class Submission < ApplicationRecord
  belongs_to :article
  belongs_to :journal
  has_many :events, class_name: 'SubmissionEvent'

  def to_s
    journal.title
  end

  def last_event
    events.order(date: :desc).first
  end
end
