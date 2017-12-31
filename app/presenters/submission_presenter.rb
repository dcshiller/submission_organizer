class SubmissionPresenter < ApplicationPresenter
  attr_reader :user, :submission, :params

  def initialize(user, submission, params)
    @user = user
    @submission = submission
    @params = params
  end

  def submissions
    user.submissions.
         joins(:journal, :latest_submission_events_by_submission).
         order(params[:order] || 'latest_submission_events_by_submissions.latest_date DESC').
         paginate(per_page: 10, page: params[:page])
  end

  def title_order_link
    order_sql = order_sql_from('articles.title', params[:order])
    directional = direction_from('articles.title', params[:order])
    link_to "Article #{directional}", submissions_path(order: order_sql)
  end

  def journal_order_link
    order_sql = order_sql_from('journals.title', params[:order])
    directional = direction_from('journals.title', params[:order])
    link_to "Journal #{directional}", submissions_path(order: order_sql)
  end

  def activity_order_link
    order_sql = order_sql_from('latest_submission_events_by_submissions.latest_date', params[:order])
    directional = direction_from('latest_submission_events_by_submissions.latest_date', params[:order])
    link_to "Date #{directional}", submissions_path(order: order_sql)
  end
end
