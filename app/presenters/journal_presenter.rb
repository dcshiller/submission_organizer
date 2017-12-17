class JournalPresenter
  attr_reader :user, :journal

  def initialize(user, journal)
    @user = user
    @journal = journal
  end

  def journals
    Journal.all.order(:title)
  end
end
