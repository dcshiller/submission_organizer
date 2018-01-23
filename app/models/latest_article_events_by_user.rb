# == Schema Information
#
# Table name: latest_article_events_by_users
#
#  article_id  :integer
#  user_id     :integer
#  latest_date :date
#

class LatestArticleEventsByUser < ApplicationRecord
  def readonly?
    true
  end
end
