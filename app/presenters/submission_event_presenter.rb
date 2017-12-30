class SubmissionEventPresenter
  attr_reader :user, :submission_event, :params

  def initialize(user, submission_event, params)
    @user = user
    @submission_event = submission_event
    @params = params
  end

  def submission
    submission_event.submission
  end

  def submission_events
    user.events.paginate(per_page: 10, page: params[:page])
  end

  def submission_article
    submission_event.submission.article
  end
end
