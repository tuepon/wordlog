class AddTimestampsToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :created_at, :datetime
    add_column :words, :updated_at, :datetime
  end
end
