class SubmissionEventsController < ApplicationController
  before_action :init_presenter

  def index; end
  def show; end

  def new
    render :new
  end

  def edit; end

  def create
    if submission_event_params_are_valid? then save_submission_event and redirect_to submission_events_path
    else new
    end
  end

  def update
  end

  private

  def init_presenter
    set_submission_event
    @presenter = SubmissionEventPresenter.new(current_user, @submission_event, params)
  end

  def submission_event_params_are_valid?
    @presenter.submission_event.valid?
  end

  def set_submission_event
    @submission_event = SubmissionEvent.find_by(id: params[:id]) || SubmissionEvent.new(submission_params_with_submission)
  end

  def submission_params_with_submission
    if submission_params
      submission_params[:submission] =
        current_user.submissions.find_or_initialize_by(article_id: submission_params[:article], journal_id: submission_params[:journal])
        submission_params.delete :article
        submission_params.delete :journal
    end
    submission_params
  end

  def save_submission_event
    if @presenter.submission_event.save
      flash[:notice] = "New Event Created!"
    end
  end

  def submission_params
    @_submission_params ||= params.permit(submission_event: [:article, :journal, :event_type, :event_subtype, :submission_id, :event_type, :date])[:submission_event]
  end
end
