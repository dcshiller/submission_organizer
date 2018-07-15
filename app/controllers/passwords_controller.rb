class PasswordsController < ApplicationController
  def forgot; end

  def reset
    user = User.find_by_email(params[:email])
    user.set_reset_token
    UserMailer.with(user: user).reset_password.deliver_now
  end

  def edit
    session[:user_id] = User.find_by_reset_token(params[:reset_token])
  end

  def update
    return if current_user.reset_token.empty
    current_user.update(user_params.merge({ reset_token: nil }))
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end
