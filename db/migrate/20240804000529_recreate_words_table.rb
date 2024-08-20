class RecreateWordsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :title
      t.string :translation
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
