class PasswordsController < ApplicationController
  def forgot; end

  def reset
    user = User.find_by_email(params[:email])
    user.set_reset_token!
    UserMailer.with(user: user).reset_password.deliver_now
  end

  def new
    return redirect_to forgot_path if params[:reset_token].blank?
    @user = User.find_by_reset_token(params[:reset_token])
    return redirect_to forgot_path unless @user
    session[:user_id] = @user.id
  end

  def create
    return redirect_to forgot_path if current_user.reset_token.blank?
    current_user.update(user_params.merge({ reset_token: nil }))
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end
