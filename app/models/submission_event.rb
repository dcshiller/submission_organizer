# == Schema Information
#
# Table name: submission_events
#
#  id            :integer          not null, primary key
#  submission_id :integer
#  event_type    :string
#  event_subtype :string
#  date          :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SubmissionEvent < ApplicationRecord
  belongs_to :submission
  has_one :article, through: :submission
  has_one :user, through: :article
  has_one :journal, through: :submission
  has_many :documents, as: :documentable
  EVENT_TYPES = %w(submission decision).freeze
  EVENT_SUBTYPES = %w(initial revise\ &\ resubmit revision rejection acceptance conditional\ acceptance).freeze
  USER_EDITABLE_ATTRS = (column_names - %w(id user_id created_at updated_at)).freeze

  scope :decision, -> { where(event_type: :decision)}

  def to_s
    "#{event_type} #{date}"
  end

  def decision
    event_type == 'decision' && event_subtype
  end
end
