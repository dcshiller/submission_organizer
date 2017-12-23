class SubmissionPresenter
  attr_reader :user, :submission

  def initialize(user, submission)
    @user = user
    @submission = submission
  end

  def submissions
    user.submissions.joins(:events).order('submission_events.date DESC')
  end
end
