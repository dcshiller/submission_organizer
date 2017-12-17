class Journal < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  
  def to_s
    title
  end

  def last_activity_for(user)
    user.submissions.where(journal: self).first.events.order(date: :desc)&.first&.date
  end
end
