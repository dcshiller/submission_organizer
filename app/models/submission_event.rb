class SubmissionEvent < ApplicationRecord
  belongs_to :submission
  has_one :article, through: :submission

  def to_s
    "#{event_type} #{date}"
  end
end
