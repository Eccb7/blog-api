class CreateArticleTags < ActiveRecord::Migration[7.0]
  def change
    create_table :article_tags, id: :uuid do |t|
      t.references :article, null: false, foreign_key: true, type: :uuid
      t.references :tag, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
