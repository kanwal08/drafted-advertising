class AddEnableApiDataToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :enable_api_data, :boolean, default: false
  end
end
