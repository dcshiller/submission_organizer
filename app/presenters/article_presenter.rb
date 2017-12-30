class ArticlePresenter
  attr_reader :user, :article, :params

  def initialize(user, article, params)
    @user = user
    @article = article
    @params = params
  end

  def articles
    user.articles.paginate(per_page: 10, page: params[:page])
  end
end
