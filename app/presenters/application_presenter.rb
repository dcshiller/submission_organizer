class ApplicationPresenter < ActionView::Base
  include Rails.application.routes.url_helpers


  def direction_from(column, order)
    if order == "#{column} ASC"
      '▲'
    elsif order == "#{column} DESC"
      '▼'
    end
  end

  def order_sql_from(column, order)
    if order == "#{column} ASC"
      "#{column} DESC"
    else
      "#{column} ASC"
    end

  end
end
