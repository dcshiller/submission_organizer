class SubmissionPresenter
  attr_reader :user, :submission

  def initialize(user, submission)
    @user = user
    @submission = submission
  end

  def submissions
    user.submissions
  end
end
