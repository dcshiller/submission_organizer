class Table
  attr_reader :query, :columns, :params, :row_form
  def initialize(params)
    @params = params
  end

  # API

  def draw_table
    view = ApplicationPresenter.new(ActionController::Base.view_paths, {})
    view.extend ApplicationHelper
    view.render(partial: 'partials/table', locals: { table: self })
  end

  # Setters

  def set_columns(column_data)
    @columns = column_data
    fill_in_order_sql
  end

  def set_query(query)
    @query = query
  end

  def set_row_form(row_form)
    @row_form = row_form
  end

  # Getters

  def column_names
    @columns.map { |c| c[:name] }
  end

  def column_value_accessors
    @columns.map { |c| c[:value_accessor] }
  end

  def current_path
    if params[:action] == 'index'
      "#{params[:controller]}_path"
    else
      "#{params[:controller].singularize}_path"
    end
  end

  def object_path
    "#{query.model.to_s.underscore}_path"
  end

  private

  # Helpers

  def belongs_to_other_table?(name)
    name != controller_model_table_name &&
      name.pluralize.in?(model_table_names)
  end

  def controller_model_table_name
    params[:controller].underscore
  end

  def direction_from(column, order)
    if order == "#{column} ASC"
      '▲'
    elsif order == "#{column} DESC"
      '▼'
    end
  end

  def fill_in_order_sql
    columns.each do |c|
      sql_sequence = c[:value_accessor].dup
      if belongs_to_other_table?(sql_sequence[0])
        singular_table_name = sql_sequence[0]
        sql_sequence[0] = singular_table_name.pluralize
      end
      c[:order_sql] = order_sql_from(sql_sequence.join('.'), params[:order])
      c[:directional] = direction_from(sql_sequence.join('.'), params[:order])
    end
  end

  def model_table_names
    ActiveRecord::Base.connection.tables + ActiveRecord::Base.connection.views
  end

  def order_sql_from(column, order)
    if order == "#{column} ASC"
      "#{column} DESC"
    else
      "#{column} ASC"
    end
  end
end
