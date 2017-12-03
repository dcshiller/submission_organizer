json.extract! submission, :id, :article_id, :journal_id, :created_at, :updated_at
json.url submission_url(submission, format: :json)
