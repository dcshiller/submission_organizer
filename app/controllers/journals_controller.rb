class JournalsController < ApplicationController
  def index
    init_presenter
  end

  def new
    init_presenter
    render :new
  end

  def create
    if journal_params_are_valid? then save_journal and redirect_to journals_path
    else new
    end
  end

  private

  def init_presenter
    @presenter = JournalPresenter.new
  end

  def journal_params_are_valid?
    journal_from_params.valid?
  end

  def save_journal
    journal_from_params.save
  end

  def journal_from_params
    Journal.new(journal_params)
  end

  def journal_params
    params.require(:journal).permit(:title)
  end
end
