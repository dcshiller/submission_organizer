class JournalPresenter
  attr_reader :user, :journal

  def initialize(user, journal)
    @user = user
    @journal = journal
  end

  def journals
    # Journal.all.order(:title)
    Journal.all.to_a
  end

  def journals_by_last_activity
    journals.sort {|a, b| b.last_activity_for(user) <=> a.last_activity_for(user)}
  end
end
