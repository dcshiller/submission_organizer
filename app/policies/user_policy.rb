class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def is?
    current_user == user
  end

  def index?;   is?  end
  def edit?;    is?  end
  def show?;    is?  end
  def update?;  is?  end
end
