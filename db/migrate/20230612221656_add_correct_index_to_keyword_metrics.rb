class AddCorrectIndexToKeywordMetrics < ActiveRecord::Migration[7.0]
  def change
    remove_index :keyword_metrics, column: [:keyword_id, :date]
    add_index :keyword_metrics, [:date, :keyword_id], unique: true
  end
end
