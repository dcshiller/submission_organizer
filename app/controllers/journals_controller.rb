class JournalsController < ApplicationController
  before_action :init_presenter

  def index; end

  def new
    render :new
  end

  def show; end

  def create
    if journal_params_are_valid? then save_journal and redirect_to journals_path
    else new
    end
  end

  private

  def init_presenter
    @presenter = JournalPresenter.new(current_user, journal_from_params, params)
  end

  def journal_params_are_valid?
    journal_from_params.valid?
  end

  def save_journal
    journal_from_params.save
  end

  def journal_from_params
    (Journal.find_by(journal_params) if journal_params) || Journal.find_by(id: params[:id]) ||
      Journal.new(journal_params)
  end

  def journal_params
    params.permit(journal: [:title] )[:journal]
  end
end
