class SubmissionsController < ApplicationController
  attr_reader :submission
  before_action :set_submission, :init_presenter

  def index; end

  def show; authorize submission end

  def new; end

  def edit; authorize submission end

  def create
    @submission = Submission.new(submission_params)
    respond_to do |format|
      if submission.save
        format.html { redirect_to submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: submission }
      else
        format.html { render :new }
        format.json { render json: submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize submission
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: submission }
      else
        format.html { render :edit }
        format.json { render json: submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize submission
    submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def init_presenter
    @presenter = SubmissionPresenter.new(current_user, submission, params)
  end

  def set_submission
    @submission = Submission.find_by(id: params[:id]) || Submission.new(submission_params)
  end

  def submission_params
    params.permit(submission: [:article_id, :journal_id])[:submission]
  end
end
