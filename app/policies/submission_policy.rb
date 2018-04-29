class SubmissionPolicy < ApplicationPolicy
  attr_reader :user, :submission

  def initialize(user, submission)
    @user = user
    @submission = submission
  end

  def belongs?
    submission.user == user
  end

  def edit?;    belongs?  end
  def show?;    belongs?  end
  def destroy?; belongs?  end
  def update?;  belongs?  end
end
