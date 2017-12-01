class UsersController < ApplicationController
  def new
    
  end

  def create
    if user_from_params.save
      login_as user_from_param
    else
      
    end
  end

  def user_from_params
    @_user ||= User.new(user_params)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
