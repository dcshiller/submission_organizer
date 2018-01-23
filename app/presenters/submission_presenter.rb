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

  def index_table
    table = Table.new(params)
    table.set_query(submissions)
    table.set_columns(
      [
        {
          name: 'Article',
          value_accessor: ['article', 'title']
        },
        {
          name: 'Journal',
          value_accessor: ['journal', 'title']
        },
        {
          name: 'Date',
          value_accessor: ['latest_submission_events_by_submission', 'latest_date']
        }
      ]
    )
    table
  end

  def show_table
    table = Table.new(params)
    table.set_query(submission.events.order(params[:order] || "date DESC"))
    table.set_columns(
      [
        {
          name: 'Type',
          value_accessor: ['event_type']
        },
        {
          name: 'Subtype',
          value_accessor: ['event_subtype']
        },
        {
          name: 'Date',
          value_accessor: ['date']
        }
      ]
    )
    table
  end
end
