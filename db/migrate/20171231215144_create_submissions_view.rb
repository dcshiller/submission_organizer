class CreateSubmissionsView < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE VIEW latest_submission_events_by_submissions AS
        SELECT
          DISTINCT ON (submissions.id) submissions.article_id AS article_id,
                                       submissions.id AS submission_id,
                                       submissions.journal_id AS journal_id,
                                       submission_events.date AS latest_date,
                                       submission_events.event_subtype AS event_subtype
        FROM
          submissions
        JOIN
          submission_events on submissions.id = submission_events.submission_id
        ORDER BY
          submissions.id, submission_events.date DESC;
    SQL
  end

  def down
    execute "DROP VIEW latest_submission_events_by_submissions"
  end
end
