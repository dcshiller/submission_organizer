class SubmissionPresenter
  attr_reader :user, :submission, :params

  def initialize(user, submission, params)
    @user = user
    @submission = submission
    @params = params
  end

  def submissions
    user.submissions.joins(:events).order('submission_events.date DESC').paginate(per_page: 10, page: params[:page])
  end
end
