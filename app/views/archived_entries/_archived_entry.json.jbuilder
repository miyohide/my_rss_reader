json.extract! archived_entry, :id, :feed_id, :title, :link, :body, :published_at, :created_at, :updated_at
json.url archived_entry_url(archived_entry, format: :json)
