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
    else flash_failed_password_alert and new 
    end
  end

  def destroy
    handle_logout
  end

  private

  def init_presenter
    @presenter = SessionPresenter.new(user)
  end

  def handle_login
    login_as user
    redirect_to root_path
  end

  def handle_logout
    logout_user
    redirect_to new_session_path
  end

  def flash_failed_password_alert
    flash['alert'] = 'Invalid user name or password'
  end

  def user
    @user ||= (
                User.where('email ILIKE ?', params[:user]&.dig(:email)).first ||
                User.new
              )
  end

  def password_match?
    user.persisted? && user&.authenticate(params[:user][:password])
  end
end
