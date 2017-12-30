class ArticlePresenter
  attr_reader :user, :article, :params

  def initialize(user, article, params)
    @user = user
    @article = article
    @params = params
  end

  def articles
    user.articles.
         includes(:latest_article_events_by_user).
         order(params[:order] || 'articles.title').
         paginate(per_page: 10, page: params[:page])
  end
end
