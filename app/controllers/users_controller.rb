class UsersController < ApplicationController
  before_action :login_required, only: :show
  before_action :init_presenter

  def new
  end

  def create
    if user_params_are_valid? then save_user
    else render :new
    end
  end

  def show
    render :show, layout: 'dashboard'
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else render :edit
    end
  end

private

  def init_presenter
    @presenter = UserPresenter.new(current_user || User.new)
  end

  def save_user
    user_from_params.save
    login_as user_from_params
    redirect_to root_path
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
