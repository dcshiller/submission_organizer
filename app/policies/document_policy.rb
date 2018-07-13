class DocumentPolicy < ApplicationPolicy
  attr_reader :user, :document

  def initialize(user, document)
    @user = user
    @document = document
  end

  def belongs?
    document.user == user
  end

  def edit?;    belongs?  end
  def show?;    belongs?  end
  def destroy?; belongs?  end
  def update?;  belongs?  end
end
