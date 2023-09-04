class RemoveLoadedInDbFromReports < ActiveRecord::Migration[6.0]
  def change
    remove_column :reports, :loaded_in_db, :boolean
  end
end
