class RecreateWordsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :new_words do |t|
      t.string :title
      t.string :translation
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    execute <<-SQL
      INSERT INTO new_words (title, translation, description, user_id, created_at, updated_at)
      SELECT title, translation, description, user_id, created_at, updated_at FROM words;
    SQL

    drop_table :words
    rename_table :new_words, :words
  end
end
