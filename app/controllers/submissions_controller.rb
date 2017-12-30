class SubmissionsController < ApplicationController
  before_action :init_presenter

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @presenter.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def init_presenter
    set_submission
    @presenter = SubmissionPresenter.new(current_user, @submission, params)
  end

  def set_submission
    @submission = Submission.find_by(id: params[:id]) || Submission.new
  end

  def submission_params
    params.permit(:submission).permit(:article_id, :journal_id)
  end
end
