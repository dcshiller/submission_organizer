class SessionsController < ApplicationController
  def new
    @presenter = SessionPresenter.new
  end

  def create
  end
end
