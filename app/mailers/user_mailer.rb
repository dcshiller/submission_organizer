class UserMailer < ApplicationMailer

  def reset_password
    @user = params[:user]
    @url = "http://test.com"
    mail(to: @user.email, subject: 'Reset Your Password')
  end
end
