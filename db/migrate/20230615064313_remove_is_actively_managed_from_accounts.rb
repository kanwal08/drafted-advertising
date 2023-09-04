class RemoveIsActivelyManagedFromAccounts < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :is_actively_managed, :boolean
  end
end
