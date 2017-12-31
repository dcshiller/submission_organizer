class Submission < ApplicationRecord
  belongs_to :article
  belongs_to :journal
  has_many :events, class_name: 'SubmissionEvent' do
    def for_journal(journal)
      where('submissions.journal_id = ?', journal.id)
    end
  end
  has_one :last_event, ->{ distinct.order('date DESC') }, class_name: 'SubmissionEvent'
  has_one :latest_submission_events_by_submission

  def to_s
    journal.title
  end
end
