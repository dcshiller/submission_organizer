class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true
  mount_uploader :file, DocumentUploader
 
  def user
    documentable.user
  end

  def documentable
    documentable_type.constantize.find(documentable_id)
  end
end
