class JournalPresenter
  attr_reader :user, :journal, :params

  def initialize(user, journal, params)
    @user = user
    @journal = journal
    @params = params
  end

  def journals
    # Journal.all.order(:title)
    Journal.all.where("title ILIKE ?", "%#{params[:query]}%").order(params[:order]).paginate(page: params[:page], per_page: 10).to_a
  end

  # def journals_by_last_activity
  #   js = journals.sort do |a, b|
  #     if !a.last_activity_for(user)
  #       1
  #     elsif !b.last_activity_for(user)
  #       -1
  #     else
  #       b.last_activity_for(user) <=> a.last_activity_for(user)
  #     end
  #   end
  # end
end
