# == Schema Information
#
# Table name: journals
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Journal < ApplicationRecord
  validates :title, uniqueness: true, presence: true

  has_many :submissions
  has_many :submission_events, through: :submissions, source: :events
  has_many :last_activity, class_name: "SubmissionEvent", through: :submissions, source: :events do
    def for_user(user)
      joins(:article).where('articles.user_id = ?', user.id).order('submission_events.date DESC').limit(1)
    end
  end
  has_one :latest_journal_events_by_user

  scope :alphabetical, -> { order(title: :asc) }

  def to_s
    title
  end

  def latest_journal_events_for_user(user_id)
    LatestJournalEventsByUser.where(user_id: user_id, journal_id: id).order("latest_date DESC").first
  end

  def method_missing(method_name, *args, &block)
  user_id = method_name.to_s.match(/latest_journal_events_for_user_(\d*)/)[1]
  if user_id
    latest_journal_events_for_user(user_id)
  else
    super
  end
  end
end
