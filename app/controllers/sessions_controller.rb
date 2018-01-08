class SessionsController < ApplicationController
  def new
    init_presenter
    render :new
  end

  def index
    redirect_to new_session_path
  end

  def create
    if password_match? then handle_login
    else
      flash["alert"] = "Invalid user name or password"
      new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private

  def init_presenter
    @presenter = SessionPresenter.new(user)
  end

  def handle_login
    login_as user
    redirect_to root_path
  end

  def user
    @user ||= User.find_or_initialize_by(email: params[:user]&.dig(:email))
  end

  def password_match?
    user.persisted? && user&.authenticate(params[:user][:password])
  end
end
