class JournalPresenter < ApplicationPresenter
  attr_reader :user, :journal, :params

  def initialize(user, journal, params)
    @user = user
    @journal = journal
    @params = params
  end

  def journals
    ar = Journal.right_joins(:latest_journal_events_by_user).
      where('latest_journal_events_by_users.user_id IS NULL OR latest_journal_events_by_users.user_id = ?', user.id).
      where("title ILIKE ?", "%#{params[:query]}%").
      order((params[:order] || 'journals.title') + " NULLS LAST", 'latest_journal_events_by_users.latest_date DESC NULLS LAST')
    ar.paginate(page: params[:page], per_page: 10, total_entries: ar.count('DISTINCT journals.id'))
  end

  def title_order_link
    order_sql = order_sql_from('journals.title', params[:order])
    directional = direction_from('journals.title', params[:order])
    link_to "Title #{directional}", journals_path(order: order_sql)
  end

  def activity_order_link
    order_sql = order_sql_from('latest_journal_events_by_users.latest_date', params[:order])
    directional = direction_from('latest_journal_events_by_users.latest_date', params[:order])
    link_to "Latest #{directional}", journals_path(order: order_sql)
  end
end
