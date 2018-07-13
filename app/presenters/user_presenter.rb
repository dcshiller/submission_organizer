class UserPresenter < ApplicationPresenter
  attr_reader :user

  ENTRIES_SHOWN = 4

  def initialize(user)
    @user = user
  end

  def articles
    Article.not_accepted.
            where(id: user.articles.submitted).
            order('articles.created_at DESC').
            limit(ENTRIES_SHOWN)
  end

  def journals
    user.articles.flat_map(&:journals).uniq[0..ENTRIES_SHOWN]
  end

  def submission_events
    user.events.order(date: :desc).limit(ENTRIES_SHOWN)
  end

  def submissions
    # Article.from(user.articles.joins("submissions").select("articles.*"), :articles)
    Submission.select("DISTINCT ON (latest_date, id) *").
               from(user.articles.joins(:submissions).
               select("DISTINCT ON (articles.id) submissions.*"), :submissions).
               joins(:latest_submission_events_by_submission).
               order('latest_date DESC').
               limit(ENTRIES_SHOWN)
  end
end
