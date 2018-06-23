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
         left_outer_joins(:latest_article_events_by_user). # includes not working with order
         order(params[:order] || 'latest_article_events_by_users.latest_date DESC').
         paginate(per_page: 10, page: params[:page])
  end

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

  def show_row_form
    row_form = RowForm.new(article.submissions.new)
    row_form.set_columns(
      [
        {
          type: :input_field,
          as: :hidden,
          prop: :article_id,
          width: '0px'
        },
        {
          type: :input,
          prop: :journal_id,
          collection: Journal.alphabetical,
          placeholder: 'Journal',
        },
        {
          barred_out: true,
          width: '120px'
        }
      ]
    )
    row_form
  end

  def show_table
    table = Table.new(params)
    table.set_query(article.submissions.
                            left_outer_joins(:latest_submission_events_by_submission, :journal).
                            order(params[:order] || 'latest_submission_events_by_submissions DESC'))
    table.set_columns(
      [
        {
          name: 'Journal',
          value_accessor: ['journal', 'title'],
        },
        {
          name: 'Latest',
          value_accessor: ['latest_submission_events_by_submission', 'latest_date'],
          width:  '120px'
        }
      ]
    )
    table.set_row_form(show_row_form)
    table
  end
end
