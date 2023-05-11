class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.references :feed, null: false, foreign_key: true
      t.string :title, null: false
      t.string :link, null: false
      t.text :body, null: false
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end
