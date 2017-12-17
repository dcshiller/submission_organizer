class UserPresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def articles
    user.articles.limit(7)
  end

  def journals
    user.articles.flat_map(&:journals).uniq[0..7]
  end

  def submission_events
    SubmissionEvent.where(submission: user.submissions).limit(7)
  end
end
