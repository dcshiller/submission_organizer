class DocumentsController < ApplicationController
  def create
    @doc = Document.new(document_params)
    @doc.file = params[:document][:file]
    @doc.save
    render json: 'done'
  end

  def document_params
    params.require(:document).permit(:file, :name, :documentable_type, :documentable_id)
  end
end
