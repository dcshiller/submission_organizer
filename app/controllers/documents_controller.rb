class DocumentsController < ApplicationController
  def create
    @doc = Document.new(document_params)
    @doc.file = params[:document][:file]
    @doc.save
    redirect_to @doc.documentable
  end

  def show
    doc = Document.find(params[:id])
    authorize doc
    send_file(doc.file.path,
              filename: doc.name,
              type: doc.file.content_type,
              disposition: 'attachment',
              url_based_filename: true)
  end

  def destroy
    authorize doc
    @doc = Document.find(params[:id])
    @doc.destroy
    redirect_to @doc.documentable
  end

  private

  def document_params
    params.require(:document).permit(:file, :name, :documentable_type, :documentable_id)
  end
end
