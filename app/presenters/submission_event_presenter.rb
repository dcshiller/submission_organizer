class SubmissionEventPresenter < ApplicationPresenter
  attr_reader :user, :submission_event, :params

  def initialize(user, submission_event, params)
    @user = user
    @submission_event = submission_event
    @params = params
  end

  def submission
    submission_event.submission
  end

  def submission_events
    user.events.joins(:journal).
         order(params[:order] || 'submission_events.date DESC').
         paginate(per_page: 10, page: params[:page])
  end

  def index_row_form
    row_form = RowForm.new(submission_event)
    row_form.set_columns(
      [
        {
          type: :input,
          prop: :article,
          collection: user.articles,
          placeholder: 'Article',
        },
        {
          type: :input,
          prop: :journal,
          collection: Journal.all,
          placeholder: 'Journal',
          width: '200px'
        },
        {
          type: :input,
          prop: :event_type,
          width: '100px'
        },
        {
          type: :input,
          prop: :event_subtype,
          width: '100px'
        },
        {
          type: :input,
          prop: :date,
          as: :string,
          placeholder: 'YY-MM-DD',
          width: '100px'
        }
      ]
    )
    row_form
  end

  def index_table
    table = Table.new(params)
    table.set_query(submission_events)
    table.set_columns(
      [
        {
          name: 'Article',
          value_accessor: ['article', 'title']
        },
        {
          name: 'Journal',
          value_accessor: ['journal', 'title'],
          width: '200px'
        },
        {
          name: 'Type',
          value_accessor: ['event_type'],
          width: '100px'
        },
        {
          name: 'Subtype',
          value_accessor: ['event_subtype'],
          width: '100px'
        },
        {
          name: 'Date',
          value_accessor: ['date'],
          width: '100px'
        }
      ]
    )
    table.set_row_form index_row_form
    table
  end

  def submission_article
    submission_event.submission.article
  end
end
