class SubmissionEventsController < ApplicationController
  before_action :init_presenter

  def index; end
  def show; end

  def new
    render :new
  end

  def edit; end

  def create
    if submission_event_params_are_valid? then save_submission_event and redirect_to submissions_path(@presenter.submission)
    else new
    end
  end

  def update
  end

  private

  def init_presenter
    set_submission_event
    @presenter = SubmissionEventPresenter.new(current_user, @submission_event)
  end

  def submission_event_params_are_valid?
    @presenter.submission_event.valid?
  end

  def set_submission_event
    @submission_event = SubmissionEvent.find_by(id: params[:id]) || SubmissionEvent.new(submission_params)
  end

  def save_submission_event
    @presenter.submission_event.save
  end

  def submission_params
    params.permit(submission_event: [:submission_id, :event_type, :date])[:submission_event]
  end
end
