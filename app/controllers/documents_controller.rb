class DocumentsController < ApplicationController
  attr_reader :doc

  def destroy
    @doc = Document.find(params[:id])
    authorize doc
    doc.destroy
    flash[:doc] = true
    redirect_to doc.documentable
  end

  def create
    @doc = Document.new(document_params)
    doc.file = params[:document][:file]
    doc.save
    flash[:doc] = true
    redirect_to @doc.documentable
  end

  def show
    doc = Document.find(params[:id])
    authorize doc
    send_data(doc.file.read,
              filename: doc.name,
              type: doc.file.content_type,
              disposition: 'attachment',
              stream: true,
              buffer_size: '4096',
             )
  end

  def update
    doc = Document.find(params[:id])
    authorize doc
    doc.update(document_params)
    flash[:doc] = true
    redirect_to doc.documentable
  end
  private

  def document_params
    params.require(:document).permit(:file, :name, :documentable_type, :documentable_id)
  end
end
