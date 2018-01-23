# == Schema Information
#
# Table name: latest_journal_events_by_users
#
#  journal_id  :integer
#  user_id     :integer
#  latest_date :date
#

class LatestJournalEventsByUser < ApplicationRecord
  def readonly?
    true
  end
end
