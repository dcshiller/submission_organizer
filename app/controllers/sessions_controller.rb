class SessionsController < ApplicationController
  def new
    init_presenter
    render :new
  end

  def create
    if password_match? then handle_login
    else new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private
  
  def init_presenter
    @presenter = SessionPresenter.new
  end

  def handle_login
    login_as user
    redirect_to root_path
  end

  def user
    User.find_by('email ILIKE ?', params[:user]&.dig(:email))
  end

  def password_match?
    user&.authenticate(params[:user][:password])
  end
end
