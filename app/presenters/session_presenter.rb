class SessionPresenter < ApplicationPresenter
  def initialize
  end

  def user
    User.new
  end
end
