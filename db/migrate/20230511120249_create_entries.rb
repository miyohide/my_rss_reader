class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.references :feed, null: false, foreign_key: true
      t.string :title
      t.string :link
      t.text :body
      t.datetime :published_at

      t.timestamps
    end
  end
end
