class UserPresenter < ApplicationPresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def articles
    user.articles.limit(5)
  end

  def journals
    user.articles.flat_map(&:journals).uniq[0..5]
  end

  def submission_events
    user.events.order(date: :desc).limit(5)
  end

  def submissions
    # Article.from(user.articles.joins("submissions").select("articles.*"), :articles)
    Submission.select("DISTINCT ON (latest_date, id) *").
               from(user.articles.joins(:submissions).select("DISTINCT ON (articles.id) submissions.*"), :submissions).
               joins(:latest_submission_events_by_submission).order('latest_date DESC').
               limit(5)
  end
end
