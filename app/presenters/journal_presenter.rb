class JournalPresenter
  def journals
    Journal.all.order(:title)
  end

  def new_journal
    Journal.new
  end
end