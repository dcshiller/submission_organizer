class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def belongs?
    article.user == user
  end

  def edit?;    belongs?  end
  def show?;    belongs?  end
  def destroy?; belongs?  end
  def update?;  belongs?  end
end
