class ApplicationController < ActionController::Base
  include Pundit
  # protect_from_forgery with: :exception

  def login_as(user)
    session[:user_id] = user.id
  end

  def logout_user
    reset_session
  end

  def login_required
    redirect_to new_session_path unless current_user
  end

  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end
end
