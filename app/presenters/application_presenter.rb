class ApplicationPresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def protect_against_forgery?
    false
  end
end
