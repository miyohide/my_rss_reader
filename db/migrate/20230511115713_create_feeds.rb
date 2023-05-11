class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds do |t|
      t.string :title, null: false, limit: 100
      t.string :endpoint, null: false, limit: 250

      t.timestamps
    end
  end
end
