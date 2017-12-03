class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.association :articles
      t.association :journals
      t.timestamps
    end
  end
end
