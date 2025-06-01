class AddBodyToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :body, :text, null: false
  end
end
