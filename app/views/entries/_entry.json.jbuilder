json.extract! entry, :id, :feed_id, :title, :link, :body, :published_at, :created_at, :updated_at
json.url entry_url(entry, format: :json)
