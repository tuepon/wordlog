class AddTelephoneToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :telephone, :string
  end
end
