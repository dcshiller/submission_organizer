class SubmissionEventPresenter < ApplicationPresenter
  attr_reader :user, :submission_event, :params

  def initialize(user, submission_event, params)
    @user = user
    @submission_event = submission_event
    @params = params
  end

  def submission
    submission_event.submission
  end

  def submission_events
    user.events.joins(:journal).
         order(params[:order] || 'submission_events.date DESC').
         paginate(per_page: 10, page: params[:page])
  end

  def title_order_link
    order_sql = order_sql_from('articles.title', params[:order])
    directional = direction_from('articles.title', params[:order])
    link_to "Title #{directional}", submission_events_path(order: order_sql)
  end

  def journal_order_link
    order_sql = order_sql_from('journals.title', params[:order])
    directional = direction_from('journals.title', params[:order])
    link_to "Journal #{directional}", submission_events_path(order: order_sql)
  end

  def type_order_link
    order_sql = order_sql_from('submission_events.event_type', params[:order])
    directional = direction_from('submission_events.event_type', params[:order])
    link_to "Type #{directional}", submission_events_path(order: order_sql)
  end

  def subtype_order_link
    order_sql = order_sql_from('submission_events.event_subtype', params[:order])
    directional = direction_from('submission_events.event_subtype', params[:order])
    link_to "Subtype #{directional}", submission_events_path(order: order_sql)
  end

  def date_order_link
    order_sql = order_sql_from('submission_events.date', params[:order])
    directional = direction_from('submission_events.date', params[:order])
    link_to "Date #{directional}", submission_events_path(order: order_sql)
  end

  def submission_article
    submission_event.submission.article
  end
end
