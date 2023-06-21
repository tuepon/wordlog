class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :original
      t.string :translation
      t.text :description
    end
  end
end
