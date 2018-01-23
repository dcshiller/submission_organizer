# == Schema Information
#
# Table name: latest_submission_events_by_submissions
#
#  article_id    :integer
#  submission_id :integer
#  journal_id    :integer
#  latest_date   :date
#

class LatestSubmissionEventsBySubmission < ApplicationRecord
  def readonly?
    true
  end
end
