class Addlatesteventview < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE VIEW latest_journal_events_by_users AS
        SELECT
          DISTINCT ON (journals.id) journals.id AS journal_id, articles.user_id AS user_id, submission_events.date AS latest_date
        FROM
          journals
        JOIN
          submissions ON journals.id = submissions.journal_id
        JOIN
          articles ON articles.id = submissions.article_id
        JOIN
          submission_events on submissions.id = submission_events.submission_id
        ORDER BY
          journals.id, submission_events.date DESC;
    SQL
  end

  def down
    execute "DROP VIEW latest_journal_events_by_users"
  end
end
