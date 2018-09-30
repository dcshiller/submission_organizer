class SubmissionPresenter < ApplicationPresenter
  attr_reader :user, :submission, :params

  def initialize(user, submission, params)
    @user = user
    @submission = submission
    @params = params
  end

  def submissions
    user.submissions.
         joins(:journal).
         left_outer_joins(:latest_submission_events_by_submission).
         order(params[:order] || 'latest_submission_events_by_submissions.latest_date DESC').
         paginate(per_page: 10, page: params[:page])
  end

  def index_row_form
    row_form = RowForm.new(submission)
    row_form.set_columns(
      [
        {
          type: :input,
          prop: :article_id,
          collection: user.articles,
          placeholder: 'Article',
          width: '200px'
        },
        {
          type: :input,
          prop: :journal_id,
          collection: Journal.all,
          placeholder: 'Journal'
        },
        {
          barred_out: true
        }
      ]
    )
    row_form
  end

  def index_table
    table = Table.new(params)
    table.set_query(submissions)
    table.set_columns(
      [
        {
          name: 'Article',
          value_accessor: ['article', 'title'],
          width: '199px'
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
    table.set_row_form(index_row_form)
    table
  end

  def show_row_form
    row_form = RowForm.new(submission.events.new)
    row_form.set_columns(
      [
        {
          type: :input,
          as: :hidden,
          prop: :submission_id,
          width: '0px'
        },
        {
          type: :input,
          prop: :event_type,
          width: '200px'
        },
        {
          type: :input,
          prop: :event_subtype,
          width: '200px'
        },
        {
          type: :input,
          prop: :date,
          as: :string,
          placeholder: 'Y-M-D',
        }
      ]
    )
    row_form
  end

  def show_table
    table = Table.new(params)
    table.set_query(submission.events.order(params[:order] || "date DESC"))
    table.set_columns(
      [
        {
          name: 'Type',
          value_accessor: ['event_type'],
          width: '200px'
        },
        {
          name: 'Subtype',
          value_accessor: ['event_subtype'],
          width: '200px'
        },
        {
          name: 'Date',
          value_accessor: ['date'],
          width: '100%'
        }
      ]
    )
    table.set_row_form(show_row_form)
    table
  end
end
