class ArticlePresenter
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def articles
    user.articles
  end
end
