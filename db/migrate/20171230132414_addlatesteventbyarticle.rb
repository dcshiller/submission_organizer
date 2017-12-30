class Addlatesteventbyarticle < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE VIEW latest_article_events_by_users AS
        SELECT
          DISTINCT ON (articles.id) articles.id AS article_id, articles.user_id AS user_id, submission_events.date AS latest_date
        FROM
          articles
        JOIN
          submissions ON articles.id = submissions.article_id
        JOIN
          submission_events on submissions.id = submission_events.submission_id
        ORDER BY
          articles.id, submission_events.date DESC;
    SQL
  end

  def down
    execute "DROP VIEW latest_article_events_by_users"
  end
end
