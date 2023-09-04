class ChangeReportDatesToDate < ActiveRecord::Migration[6.1]
  def up
    change_column :reports, :start_date, 'date USING start_date::date'
    change_column :reports, :end_date, 'date USING end_date::date'
  end

  def down
    change_column :reports, :start_date, :string
    change_column :reports, :end_date, :string
  end
end
