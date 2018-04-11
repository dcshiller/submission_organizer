class RowForm
  attr_reader :id, :ar_model
  def initialize(ar_model)
    @id = SecureRandom.base64
    @ar_model = ar_model
  end

  def barred_outs
    @columns.count { |c| c[:barred_out] }
  end

  def draw_form
    view = ApplicationPresenter.new(ActionController::Base.view_paths, {})
    view.extend ApplicationHelper
    view.render(partial: 'partials/row_form', locals: { row_form: self })
  end

  def form_inputs(f)
    inputs.map do |column|
      f.send(column[:type], column[:prop], collection: column[:collection],
                                           label: false,
                                           wrapper: false,
                                           as: column[:as],
                                           input_html: { style: "width: #{column[:width]};"},
                                           placeholder: column[:placeholder])
    end
  end

  def inputs
    @columns.select { |c| !c[:barred_out] }
  end

	def input_width
		inputs.count
	end

  def set_columns(input_columns)
    @columns = input_columns
  end
end
