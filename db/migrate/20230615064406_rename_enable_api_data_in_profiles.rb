class RenameEnableApiDataInProfiles < ActiveRecord::Migration[6.1]
  def change
    rename_column :profiles, :enable_api_data, :is_actively_managed
  end
end
