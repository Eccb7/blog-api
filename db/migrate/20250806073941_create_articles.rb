class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :title
      t.text :content
      t.text :tags, array: true, default: []
      t.datetime :published_at
      t.string :slug

      t.timestamps
    end
    add_index :articles, :title, unique: true
    add_index :articles, :slug, unique: true
  end
end
