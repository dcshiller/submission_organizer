class CreateSubmissionEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :submission_events do |t|
      t.references :submission
      t.string :event_type
      t.string :event_subtype
      t.date :date
      t.timestamps
    end
  end
end
