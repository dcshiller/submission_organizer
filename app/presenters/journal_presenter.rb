class JournalPresenter
  attr_reader :user, :journal, :params

  def initialize(user, journal, params)
    @user = user
    @journal = journal
    @params = params
  end

  def journals
    ar = Journal.includes(:latest_journal_events_by_user).
      where('latest_journal_events_by_users.user_id IS NULL OR latest_journal_events_by_users.user_id = ?', user.id).
      where("title ILIKE ?", "%#{params[:query]}%").
      order((params[:order] || 'journals.title') + " NULLS LAST", 'latest_journal_events_by_users.latest_date DESC NULLS LAST')
    ar.paginate(page: params[:page], per_page: 10, total_entries: ar.count('DISTINCT journals.id'))
  end
end
