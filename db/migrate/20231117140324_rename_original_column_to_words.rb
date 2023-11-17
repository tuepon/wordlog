class RenameOriginalColumnToWords < ActiveRecord::Migration[7.0]
  def change
    rename_column :words, :original, :title
  end
end
