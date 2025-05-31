class AddEmailToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :email, :string, null: false
  end
end
