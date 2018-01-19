class SubmissionEvent < ApplicationRecord
  belongs_to :submission
  has_one :article, through: :submission
  has_one :journal, through: :submission
  EVENT_TYPES = %w(submission decision).freeze
  EVENT_SUBTYPES = %w(initial revise\ &\ resubmit revision rejection acceptance conditional\ acceptance).freeze

  scope :decision, -> { where(event_type: :decision)}

  def to_s
    "#{event_type} #{date}"
  end

  def decision
    event_type == 'decision' && event_subtype
  end
end
