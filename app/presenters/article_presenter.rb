class ArticlePresenter < ApplicationPresenter
  attr_reader :user, :article, :params
  include Rails.application.routes.url_helpers

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

  def title_order_link
    order_sql = order_sql_from('articles.title', params[:order])
    directional = direction_from('articles.title', params[:order])
    link_to "Title #{directional}", articles_path(order: order_sql)
  end

  def latest_activity_link
    order_sql = order_sql_from('latest_article_events_by_users.latest_date', params[:order])
    directional = direction_from('latest_article_events_by_users.latest_date', params[:order])
    link_to "Latest #{directional}", articles_path(order: order_sql)
  end
end
