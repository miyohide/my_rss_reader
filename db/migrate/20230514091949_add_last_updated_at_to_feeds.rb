class AddLastUpdatedAtToFeeds < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :last_updated_at, :datetime
  end
end
