class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login_as(user)
    session[:user_id] = user.id
  end
end
