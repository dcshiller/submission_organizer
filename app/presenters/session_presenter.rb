class SessionPresenter < ApplicationPresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end
end
