class Journal < ApplicationRecord
  validates :title, uniqueness: true, presence: true

  has_many :submissions
  has_many :submission_events, through: :submissions, source: :events
  has_many :last_activity, class_name: "SubmissionEvent", through: :submissions, source: :events do
    def for_user(user)
      joins(:article).where('articles.user_id = ?', user.id).order('submission_events.date DESC').limit(1)
    end
  end
  has_many :latest_journal_events_by_user
  def to_s
    title
  end
end
