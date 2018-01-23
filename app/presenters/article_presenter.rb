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

  # def title_order_link
  #   order_sql = order_sql_from('articles.title', params[:order])
  #   directional = direction_from('articles.title', params[:order])
  #   link_to "Title #{directional}", articles_path(order: order_sql)
  # end
  # 
  # def latest_activity_link
  #   order_sql = order_sql_from('latest_article_events_by_users.latest_date', params[:order])
  #   directional = direction_from('latest_article_events_by_users.latest_date', params[:order])
  #   link_to "Latest #{directional}", articles_path(order: order_sql)
  # end

  def index_row_form
    row_form = RowForm.new(article)
    row_form.set_columns(
      [
        {
          type: :input,
          prop: :title,
          placeholder: 'New Article'
        },
        {
          barred_out: true
        }
      ]
    )
    row_form
  end

  def index_table
    table = Table.new(params)
    table.set_query(articles)
    table.set_columns(
      [
        {
          name: 'Title',
          value_accessor: ['title']
        },
        {
          name: 'Latest',
          value_accessor: ['latest_article_events_by_user', 'latest_date'],
          width: '120px'
        }
      ]
    )
    table.set_row_form(index_row_form)
    table
  end

  def show_table
    table = Table.new(params)
    table.set_query(article.submissions.joins(:latest_submission_events_by_submission, :journal).order(params[:order]))
    table.set_columns(
      [
        {
          name: 'Journal',
          value_accessor: ['journal', 'title']
        },
        {
          name: 'Latest',
          value_accessor: ['latest_submission_events_by_submission', 'latest_date']
        }
      ]
    )
    table
  end
end
