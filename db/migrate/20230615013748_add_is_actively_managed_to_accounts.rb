class AddIsActivelyManagedToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :is_actively_managed, :boolean, default: false
  end
end
