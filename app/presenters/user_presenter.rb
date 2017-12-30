class UserPresenter
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
end
