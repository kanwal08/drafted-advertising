class RemoveLoadedInDbAndLocationFromSnapshots < ActiveRecord::Migration[6.0]
  def change
    remove_column :snapshots, :loaded_in_db, :boolean
    remove_column :snapshots, :location, :string
  end
end
