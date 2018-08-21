class PasswordsPresenter < ApplicationPresenter
  attr_reader :user

  def initialize(params)
    @user = User.find_by_reset_token(params[:reset_token])
  end
end
