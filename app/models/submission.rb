# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  article_id :integer
#  journal_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ApplicationRecord
  belongs_to :article
  belongs_to :journal
  has_many :events, class_name: 'SubmissionEvent' do
    def for_journal(journal)
      where('submissions.journal_id = ?', journal.id)
    end
  end
  has_one :last_event, -> { distinct.order('date DESC') }, class_name: 'SubmissionEvent'
  has_one :latest_submission_events_by_submission

  def to_s
    journal.title
  end
end
