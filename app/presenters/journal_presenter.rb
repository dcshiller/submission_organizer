class JournalPresenter < ApplicationPresenter
  attr_reader :user, :journal, :params

  def initialize(user, journal, params)
    @user = user
    @journal = journal
    @params = params
  end

  def journals
    ar = Journal.select("*, latest_journal_events_by_users.latest_date").
                 joins("FULL OUTER JOIN latest_journal_events_by_users ON journals.id = latest_journal_events_by_users.journal_id").
                 where("title ILIKE ?", "%#{params[:query]}%").
                 order("CASE WHEN latest_journal_events_by_users.user_id = #{user.id} THEN 0 ELSE 1 END").
                 order((params[:order] || 'journals.title') + " NULLS LAST", 'latest_journal_events_by_users.latest_date DESC NULLS LAST')
    Journal.from(ar, :journals).paginate(page: params[:page], per_page: 10, total_entries: ar.count('DISTINCT journals.id'))
  end

  def submissions
    user.submissions.where(journal: journal)
  end

  def index_row_form
    row_form = RowForm.new(journal)
    row_form.set_columns(
      [
        {
          type: :input,
          prop: :title,
          placeholder: 'New Journal'
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
    table.set_query(journals)
    table.set_columns(
      [
        {
          name: 'Title',
          value_accessor: ['title']
        },
        {
          name: 'Latest',
          value_accessor: ['latest_journal_events_by_user', 'latest_date'],
          width: '120px'
        }
      ]
    )
    table.set_row_form(index_row_form)
    table
  end

  def show_table
    table = Table.new(params)
    table.set_query(submissions.joins(:latest_submission_events_by_submission).order(params[:order]))
    table.set_columns(
      [
        {
          name: 'Title',
          value_accessor: ['article']
        },
        {
          name: 'Latest',
          value_accessor: ['latest_submission_events_by_submission', 'latest_date']
        },
        {
          name: 'Result',
          value_accessor: ['latest_submission_events_by_submission', 'event_subtype']
        }
      ]
    )
    table
  end
end
