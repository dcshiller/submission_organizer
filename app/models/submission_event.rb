class SubmissionEvent < ApplicationRecord
  belongs_to :submission
  has_one :article, through: :submission
  has_one :journal, through: :article

  scope :decision, -> { where(event_type: :decision)}

  def to_s
    "#{event_type} #{date}"
  end

  def decision
    event_type == 'decision' && event_subtype
  end
end
