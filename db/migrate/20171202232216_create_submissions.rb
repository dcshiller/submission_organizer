class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.references :article, foreign_key: true
      t.references :journal, foreign_key: true

      t.timestamps
    end
  end
end
