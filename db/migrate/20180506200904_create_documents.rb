class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string        :file
      t.string        :name
      t.integer       :documentable_id
      t.string        :documentable_type
      t.timestamps
    end
  end
end
