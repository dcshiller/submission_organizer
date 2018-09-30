module ApplicationHelper
  def current_user
    @_user ||= User.find_by(id: session[:user_id])
  end

  def line_form(model, field)
    render 'partials/line_form', model: model, field: field
  end

  def line_form_association_for(model, field, collection)
    render 'partials/line_form_assoc', model: model, field: field, collection: collection
  end

  def line_form_select_for(model, field, collection)
    render 'partials/line_form_select', model: model, field: field, collection: collection
  end

  def line_form_date_for(model, field)
    render 'partials/line_form_date', model: model, field: field
  end
end
