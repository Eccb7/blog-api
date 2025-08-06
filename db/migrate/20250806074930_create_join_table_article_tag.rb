class CreateJoinTableArticleTag < ActiveRecord::Migration[8.0]
  def change
    create_join_table :articles, :tags, column_options: { type: :uuid } do |t|
      t.index [:article_id, :tag_id], unique: true
    end
  end
end
