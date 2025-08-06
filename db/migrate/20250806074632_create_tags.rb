class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :name, null: false
      t.integer :count, default: 0

      t.timestamps

      t.index :name, unique: true
      t.index :count
    end
  end
end
