class SubmissionEventPolicy < ApplicationPolicy
  attr_reader :user, :submission_event

  def initialize(user, submission_event)
    @user = user
    @submission_event = submission_event
  end

  def belongs?
    submission_event.user == user
  end

  def edit?;    belongs?  end
  def show?;    belongs?  end
  def destroy?; belongs?  end
  def update?;  belongs?  end
end
