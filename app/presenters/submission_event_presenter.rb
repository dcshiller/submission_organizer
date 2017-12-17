class SubmissionEventPresenter
  attr_reader :user, :submission_event

  def initialize(user, submission_event)
    @user = user
    @submission_event = submission_event
  end

  def submission
    submission_event.submission
  end

  def submission_events
    user.events
  end

  def submission_article
    submission_event.submission.article
  end
end
