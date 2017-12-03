class UsersController < ApplicationController
  before_action :login_required, only: :show
  
  def new
    init_presenter
  end

  def create
    if user_params_are_valid? then save_user
    else render :new
    end
  end

  def show; end

private
  
  def init_presenter
    @presenter = UserPresenter.new
  end

  def save_user
    user_from_params.save
    login_as user_from_params
    redirect_to assignments_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def user_from_params
    @_user ||= User.new(user_params)
  end

  def user_params_are_valid?
    user_from_params.valid?
  end
  end
